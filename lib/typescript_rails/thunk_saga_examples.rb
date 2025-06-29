# frozen_string_literal: true

# Thunk and Saga Examples for API Calls
# Provides comprehensive examples of Redux Thunk and Redux Saga patterns

module TypeScriptRails
  module ThunkSagaExamples
    # Redux Thunk Examples
    module ThunkExamples
      # Basic thunk example
      def self.basic_thunk
        <<~JS
          // Basic thunk
          export const fetchUser = (id) => async (dispatch) => {
            dispatch({ type: 'FETCH_USER_START' });
            try {
              const response = await fetch(`/api/users/${id}`);
              const user = await response.json();
              dispatch({ type: 'FETCH_USER_SUCCESS', payload: user });
            } catch (error) {
              dispatch({ type: 'FETCH_USER_ERROR', payload: error.message });
            }
          };
        JS
      end

      # Thunk with parameters
      def self.thunk_with_params
        <<~JS
          // Thunk with parameters
          export const createUser = (userData) => async (dispatch) => {
            dispatch({ type: 'CREATE_USER_START' });
            try {
              const response = await fetch('/api/users', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(userData)
              });
              const user = await response.json();
              dispatch({ type: 'CREATE_USER_SUCCESS', payload: user });
            } catch (error) {
              dispatch({ type: 'CREATE_USER_ERROR', payload: error.message });
            }
          };
        JS
      end

      # Thunk with getState
      def self.thunk_with_get_state
        <<~JS
          // Thunk with getState
          export const updateUser = (id, updates) => async (dispatch, getState) => {
            const { auth } = getState();
            if (!auth.token) {
              dispatch({ type: 'UPDATE_USER_ERROR', payload: 'No auth token' });
              return;
            }
          #{'  '}
            dispatch({ type: 'UPDATE_USER_START' });
            try {
              const response = await fetch(`/api/users/${id}`, {
                method: 'PUT',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': `Bearer ${auth.token}`
                },
                body: JSON.stringify(updates)
              });
              const user = await response.json();
              dispatch({ type: 'UPDATE_USER_SUCCESS', payload: user });
            } catch (error) {
              dispatch({ type: 'UPDATE_USER_ERROR', payload: error.message });
            }
          };
        JS
      end
    end

    # Redux Saga Examples
    module SagaExamples
      # Basic saga example
      def self.basic_saga
        <<~JS
          // Basic saga
          import { call, put, takeLatest } from 'redux-saga/effects';

          function* fetchUser(action) {
            try {
              const user = yield call(fetchUserApi, action.payload);
              yield put({ type: 'FETCH_USER_SUCCESS', payload: user });
            } catch (error) {
              yield put({ type: 'FETCH_USER_ERROR', payload: error.message });
            }
          }

          export function* userSaga() {
            yield takeLatest('FETCH_USER_START', fetchUser);
          }
        JS
      end

      # Saga with multiple effects
      def self.saga_with_effects
        <<~JS
          // Saga with multiple effects
          import { call, put, takeLatest, select } from 'redux-saga/effects';

          function* createUser(action) {
            try {
              // Get current state
              const auth = yield select(state => state.auth);
          #{'    '}
              // Call API
              const user = yield call(createUserApi, action.payload, auth.token);
          #{'    '}
              // Update state
              yield put({ type: 'CREATE_USER_SUCCESS', payload: user });
          #{'    '}
              // Navigate
              yield put({ type: 'NAVIGATE', payload: `/users/${user.id}` });
            } catch (error) {
              yield put({ type: 'CREATE_USER_ERROR', payload: error.message });
            }
          }

          export function* userSaga() {
            yield takeLatest('CREATE_USER_START', createUser);
          }
        JS
      end

      # Saga with cancellation
      def self.saga_with_cancellation
        <<~JS
          // Saga with cancellation
          import { call, put, takeLatest, cancelled } from 'redux-saga/effects';

          function* fetchUsers() {
            try {
              const users = yield call(fetchUsersApi);
              yield put({ type: 'FETCH_USERS_SUCCESS', payload: users });
            } catch (error) {
              yield put({ type: 'FETCH_USERS_ERROR', payload: error.message });
            } finally {
              if (yield cancelled()) {
                // Cleanup if cancelled
                yield put({ type: 'FETCH_USERS_CANCELLED' });
              }
            }
          }

          export function* userSaga() {
            yield takeLatest('FETCH_USERS_START', fetchUsers);
          }
        JS
      end
    end

    # Redux Toolkit Query Examples
    module RTKQueryExamples
      def self.rtk_query_examples
        <<~TYPESCRIPT
          // RTK Query Examples
          import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';
          import { apiClient } from '../services/apiClient';

          // Basic RTK Query API
          export const userApi = createApi({
            reducerPath: 'userApi',
            baseQuery: fetchBaseQuery({#{' '}
              baseUrl: '/api',
              prepareHeaders: (headers, { getState }) => {
                const token = getState().auth.token;
                if (token) {
                  headers.set('authorization', `Bearer ${token}`);
                }
                return headers;
              }
            }),
            tagTypes: ['User', 'UserList'],
            endpoints: (builder) => ({
              getUser: builder.query({
                query: (id) => `users/${id}`,
                providesTags: (result, error, id) => [{ type: 'User', id }]
              }),
              getUsers: builder.query({
                query: (params) => ({
                  url: 'users',
                  params
                }),
                providesTags: ['UserList']
              }),
              createUser: builder.mutation({
                query: (user) => ({
                  url: 'users',
                  method: 'POST',
                  body: user
                }),
                invalidatesTags: ['UserList']
              }),
              updateUser: builder.mutation({
                query: ({ id, ...patch }) => ({
                  url: `users/${id}`,
                  method: 'PATCH',
                  body: patch
                }),
                invalidatesTags: (result, error, { id }) => [
                  { type: 'User', id },
                  'UserList'
                ]
              }),
              deleteUser: builder.mutation({
                query: (id) => ({
                  url: `users/${id}`,
                  method: 'DELETE'
                }),
                invalidatesTags: ['UserList']
              })
            })
          });

          // RTK Query with custom base query
          const customBaseQuery = fetchBaseQuery({
            baseUrl: '/api',
            prepareHeaders: (headers, { getState }) => {
              const token = getState().auth.token;
              if (token) {
                headers.set('authorization', `Bearer ${token}`);
              }
              return headers;
            }
          });

          const baseQueryWithRetry = async (args: any, api: any, extraOptions: any) => {
            let result = await customBaseQuery(args, api, extraOptions);
          #{'  '}
            if (result.error && result.error.status === 401) {
              // Try to refresh token
              const refreshResult = await customBaseQuery(
                { url: '/auth/refresh', method: 'POST' },
                api,
                extraOptions
              );
          #{'    '}
              if (refreshResult.data) {
                // Retry original request
                result = await customBaseQuery(args, api, extraOptions);
              }
            }
          #{'  '}
            return result;
          };

          export const advancedUserApi = createApi({
            reducerPath: 'advancedUserApi',
            baseQuery: baseQueryWithRetry,
            tagTypes: ['User', 'UserList'],
            endpoints: (builder) => ({
              getUserWithCache: builder.query({
                query: (id) => `users/${id}`,
                providesTags: (result, error, id) => [{ type: 'User', id }],
                keepUnusedDataFor: 300, // 5 minutes
                transformResponse: (response: any) => ({
                  ...response,
                  fetchedAt: Date.now()
                })
              }),
              getUsersWithPagination: builder.query({
                query: ({ page = 1, limit = 10, ...params }) => ({
                  url: 'users',
                  params: { page, limit, ...params }
                }),
                providesTags: (result, error, { page }) =>
                  result
                    ? [
                        ...result.data.map(({ id }: any) => ({ type: 'User' as const, id })),
                        { type: 'UserList', id: `LIST-${page}` }
                      ]
                    : [{ type: 'UserList', id: 'LIST' }],
                serializeQueryArgs: ({ queryArgs }) => {
                  const { page, ...otherArgs } = queryArgs;
                  return otherArgs;
                },
                merge: (currentCache, newItems) => {
                  currentCache.data.push(...newItems.data);
                },
                forceRefetch: ({ currentArg, previousArg }) => {
                  return currentArg !== previousArg;
                }
              }),
              uploadUserAvatar: builder.mutation({
                query: ({ userId, file }) => {
                  const formData = new FormData();
                  formData.append('avatar', file);
          #{'        '}
                  return {
                    url: `users/${userId}/avatar`,
                    method: 'POST',
                    body: formData
                  };
                },
                invalidatesTags: (result, error, { userId }) => [
                  { type: 'User', id: userId }
                ]
              })
            })
          });

          // RTK Query with optimistic updates
          export const optimisticUserApi = createApi({
            reducerPath: 'optimisticUserApi',
            baseQuery: fetchBaseQuery({ baseUrl: '/api' }),
            tagTypes: ['User'],
            endpoints: (builder) => ({
              updateUserOptimistic: builder.mutation({
                query: ({ id, ...patch }) => ({
                  url: `users/${id}`,
                  method: 'PATCH',
                  body: patch
                }),
                async onQueryStarted({ id, ...patch }, { dispatch, queryFulfilled }) {
                  const patchResult = dispatch(
                    optimisticUserApi.util.updateQueryData('getUser', id, (draft) => {
                      Object.assign(draft, patch);
                    })
                  );
          #{'        '}
                  try {
                    await queryFulfilled;
                  } catch {
                    patchResult.undo();
                  }
                }
              })
            })
          });

          // Export hooks
          export const {
            useGetUserQuery,
            useGetUsersQuery,
            useCreateUserMutation,
            useUpdateUserMutation,
            useDeleteUserMutation
          } = userApi;

          export const {
            useGetUserWithCacheQuery,
            useGetUsersWithPaginationQuery,
            useUploadUserAvatarMutation
          } = advancedUserApi;

          export const {
            useUpdateUserOptimisticMutation
          } = optimisticUserApi;
        TYPESCRIPT
      end
    end

    # Usage examples
    def self.usage_examples
      <<~TYPESCRIPT
        // Usage Examples
        import React from 'react';
        import { useDispatch, useSelector } from 'react-redux';
        import {#{' '}
          fetchUser,#{' '}
          fetchUserWithRetry,#{' '}
          fetchUserWithCache#{' '}
        } from './thunkExamples';
        import {#{' '}
          useGetUserQuery,#{' '}
          useUpdateUserMutation#{' '}
        } from './rtkQueryExamples';

        // Thunk Usage
        const UserProfileThunk = ({ userId }: { userId: string }) => {
          const dispatch = useDispatch();
          const { user, loading, error } = useSelector((state: any) => state.user);

          React.useEffect(() => {
            dispatch(fetchUserWithRetry(userId));
          }, [dispatch, userId]);

          if (loading) return <div>Loading...</div>;
          if (error) return <div>Error: {error}</div>;

          return (
            <div>
              <h1>{user?.name}</h1>
              <p>{user?.email}</p>
            </div>
          );
        };

        // RTK Query Usage
        const UserProfileRTK = ({ userId }: { userId: string }) => {
          const { data: user, isLoading, error } = useGetUserQuery(userId);
          const [updateUser, { isLoading: isUpdating }] = useUpdateUserMutation();

          const handleUpdate = async (userData: any) => {
            try {
              await updateUser({ id: userId, ...userData }).unwrap();
            } catch (error) {
              console.error('Failed to update user:', error);
            }
          };

          if (isLoading) return <div>Loading...</div>;
          if (error) return <div>Error: {error}</div>;

          return (
            <div>
              <h1>{user?.name}</h1>
              <p>{user?.email}</p>
              <button#{' '}
                onClick={() => handleUpdate({ name: 'New Name' })}
                disabled={isUpdating}
              >
                {isUpdating ? 'Updating...' : 'Update Name'}
              </button>
            </div>
          );
        };

        // Saga Usage (in component)
        const UserProfileSaga = ({ userId }: { userId: string }) => {
          const dispatch = useDispatch();
          const { user, loading, error } = useSelector((state: any) => state.user);

          React.useEffect(() => {
            dispatch({ type: 'user/fetchUserRequest', payload: userId });
          }, [dispatch, userId]);

          if (loading) return <div>Loading...</div>;
          if (error) return <div>Error: {error}</div>;

          return (
            <div>
              <h1>{user?.name}</h1>
              <p>{user?.email}</p>
            </div>
          );
        };
      TYPESCRIPT
    end

    # Configuration and setup
    def self.configuration_examples
      <<~TYPESCRIPT
        // Store Configuration Examples
        import { configureStore } from '@reduxjs/toolkit';
        import createSagaMiddleware from 'redux-saga';
        import { userApi } from './rtkQueryExamples';
        import { userSaga } from './sagaExamples';

        // Store with Thunks (default)
        export const store = configureStore({
          reducer: {
            user: userReducer,
            [userApi.reducerPath]: userApi.reducer
          },
          middleware: (getDefaultMiddleware) =>
            getDefaultMiddleware().concat(userApi.middleware)
        });

        // Store with Sagas
        const sagaMiddleware = createSagaMiddleware();

        export const storeWithSaga = configureStore({
          reducer: {
            user: userReducer,
            [userApi.reducerPath]: userApi.reducer
          },
          middleware: (getDefaultMiddleware) =>
            getDefaultMiddleware({
              thunk: false // Disable thunks when using sagas
            }).concat(sagaMiddleware, userApi.middleware)
        });

        sagaMiddleware.run(userSaga);

        // Store with both Thunks and Sagas
        export const storeWithBoth = configureStore({
          reducer: {
            user: userReducer,
            [userApi.reducerPath]: userApi.reducer
          },
          middleware: (getDefaultMiddleware) =>
            getDefaultMiddleware().concat(sagaMiddleware, userApi.middleware)
        });

        sagaMiddleware.run(userSaga);
      TYPESCRIPT
    end

    # Generate all examples
    def self.generate_all_examples
      {
        thunk_basic: ThunkExamples.basic_thunk,
        thunk_with_params: ThunkExamples.thunk_with_params,
        thunk_with_get_state: ThunkExamples.thunk_with_get_state,
        saga_basic: SagaExamples.basic_saga,
        saga_with_effects: SagaExamples.saga_with_effects,
        saga_with_cancellation: SagaExamples.saga_with_cancellation,
        rtk_query: RTKQueryExamples.rtk_query_examples,
        usage: usage_examples,
        configuration: configuration_examples,
      }
    end
  end
end
