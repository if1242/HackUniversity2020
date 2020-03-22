//
//  FriendsListService.swift
//  HackAR
//
//  Created by viktor.volkov on 22.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation

class FriendsListService {
    
    private enum Constants {
        static let users = "https://sandbox.rightech.io/api/v1/objects"
        static let bearer = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJoRi01RFdUUENiRFNGZnhfTjdlREYiLCJzdWIiOiI1ZTc0YzY5ZGM3ODljNDY1MmIzNzIwZDYiLCJncnAiOiI1ZTc0YzY5ZGM3ODljNDY1MmIzNzIwZDUiLCJ1c2VyIjoiaHUyMDIwLTA1IiwicmlnaHRzIjoxLjUsInNjb3BlcyI6WyJtb2RlbHNfZ2V0IiwibW9kZWxzX29uZV9nZXQiLCJtb2RlbHNfcG9zdCIsIm1vZGVsc19vbmVfcGF0Y2giLCJtb2RlbHNfb25lX2RlbGV0ZSIsIm1vZGVsc19hY2Nlc3NfcG9zdCIsIm1vZGVsc19hY2Nlc3NfZGVsZXRlIiwibW9kZWxzX29uZV9ub2Rlc19wb3N0IiwibW9kZWxzX29uZV9ub2Rlc19ub2RlX3BhdGNoIiwibW9kZWxzX29uZV9ub2Rlc19ub2RlX2RlbGV0ZSIsIm1vZGVsc19vbmVfYXJndW1lbnRzX2dldCIsIm1vZGVsc19vbmVfY29tbWFuZHNfZ2V0IiwibW9kZWxzX29uZV9ldmVudHNfZ2V0Iiwib2JqZWN0c19nZXQiLCJvYmplY3RzX29uZV9nZXQiLCJvYmplY3RzX3Bvc3QiLCJvYmplY3RzX29uZV9wYXRjaCIsIm9iamVjdHNfb25lX2RlbGV0ZSIsIm9iamVjdHNfYWNjZXNzX3Bvc3QiLCJvYmplY3RzX2FjY2Vzc19kZWxldGUiLCJvYmplY3RzX29uZV9wYWNrZXRzX2dldCIsIm9iamVjdHNfb25lX3BhY2tldHNfcGFja2V0aWRfZ2V0Iiwib2JqZWN0c19vbmVfbW9kZWxfcG9zdCIsIm9iamVjdHNfb25lX3Rhc2tfY2hhbmdlaWRfcG9zdCIsIm9iamVjdHNfb25lX3Rhc2tfY2VydF9wb3N0Iiwib2JqZWN0c19vbmVfdGFza19kZWxldGVfcG9zdCIsIm9iamVjdHNfb25lX3BhY2tldHNfcG9zdCIsImNvbW1hbmRzX3dlYl9vYmplY3RzX29uZV9jb21tYW5kc19nZXRfc3RhdGVfcG9zdCIsImNvbW1hbmRzX3dlYl9vYmplY3RzX29uZV9jb21tYW5kc19kaXNjb25uZWN0X3Bvc3QiLCJjb21tYW5kc193ZWJfb2JqZWN0c19vbmVfY29tbWFuZHNfcHVibGlzaF9wb3N0IiwiY29tbWFuZHNfd2ViX29iamVjdHNfb25lX2NvbW1hbmRzX3RleHRfY29tbWFuZF9wb3N0IiwiY29tbWFuZHNfd2ViX29iamVjdHNfb25lX2NvbW1hbmRzX3VwZGF0ZV9tb2RlbF9wb3N0IiwiY29tbWFuZHNfd2ViX29iamVjdHNfb25lX2NvbW1hbmRzX3NlcnZpY2VfcG9zdCIsImNvbW1hbmRzX3dlYl9vYmplY3RzX29uZV9jb21tYW5kc19pbmZvX3Bvc3QiLCJjb21tYW5kc193ZWJfb2JqZWN0c19vbmVfY29tbWFuZHNfY29udHJvbF9wb3N0IiwiY29tbWFuZHNfd2ViX29iamVjdHNfb25lX2NvbW1hbmRzX2Rhbmdlcl9wb3N0IiwiY29tbWFuZHNfd2ViX29iamVjdHNfb25lX2NvbW1hbmRzX2NvbW1hbmRfcG9zdCIsImxvZ2ljX2F1dG9tYXRvbnNfb25lX3N0YXR1c2VzX2dldCIsImxvZ2ljX29iamVjdHNfb25lX2F1dG9tYXRvbnNfYXV0b21hdG9uX2dldCIsImxvZ2ljX29iamVjdHNfb25lX2F1dG9tYXRvbnNfYXV0b21hdG9uX2xvZ3NfZ2V0IiwibG9naWNfb2JqZWN0c19vbmVfYXV0b21hdG9uc19hdXRvbWF0b25fc3RhcnRfcG9zdCIsImxvZ2ljX29iamVjdHNfb25lX2F1dG9tYXRvbnNfYXV0b21hdG9uX2VtaXRfcG9zdCIsImxvZ2ljX29iamVjdHNfb25lX2F1dG9tYXRvbnNfYXV0b21hdG9uX3N0b3BfcG9zdCIsImxvZ2ljX2F1dG9tYXRvbnNfZ2V0IiwibG9naWNfYXV0b21hdG9uc19vbmVfZ2V0IiwibG9naWNfYXV0b21hdG9uc19wb3N0IiwibG9naWNfYXV0b21hdG9uc19vbmVfcGF0Y2giLCJsb2dpY19hdXRvbWF0b25zX29uZV9kZWxldGUiLCJsb2dpY19hdXRvbWF0b25zX2FjY2Vzc19wb3N0IiwibG9naWNfYXV0b21hdG9uc19hY2Nlc3NfZGVsZXRlIiwibG9naWNfb2JqZWN0c19vbmVfY29udGFpbmVyc19nZXQiLCJsb2dpY19vYmplY3RzX29uZV9jb250YWluZXJzX3V1aWRfZ2V0IiwibG9naWNfb2JqZWN0c19vbmVfY29udGFpbmVyc191dWlkX3Bvc3QiLCJsb2dpY19vYmplY3RzX29uZV9jb250YWluZXJzX3V1aWRfZGVsZXRlIiwibG9naWNfb2JqZWN0c19vbmVfY29udGFpbmVyc191dWlkX3N0YXJ0X3Bvc3QiLCJsb2dpY19vYmplY3RzX29uZV9jb250YWluZXJzX3V1aWRfc3RvcF9wb3N0IiwibG9naWNfb2JqZWN0c19vbmVfZW1pdF9wb3N0IiwibG9naWNfb2JqZWN0c19vbmVfY29udGFpbmVyc191dWlkX2VtaXRfcG9zdCIsImxvZ2ljX29iamVjdHNfb25lX2F1dG9tYXRvbl90ZW1wbGF0ZWlkX3Bvc3QiLCJsb2dpY19hdXRvbWF0b25zX29uZV9kYXRhX2dldCIsImhhbmRsZXJzX2dldCIsImhhbmRsZXJzX29uZV9nZXQiLCJoYW5kbGVyc19wb3N0IiwiaGFuZGxlcnNfb25lX3BhdGNoIiwiaGFuZGxlcnNfb25lX2RlbGV0ZSIsImhhbmRsZXJzX2FjY2Vzc19wb3N0IiwiaGFuZGxlcnNfYWNjZXNzX2RlbGV0ZSIsImhhbmRsZXJzX3Rlc3RfY29kZV9wb3N0IiwiZHJpdmVyc19nZXQiLCJkcml2ZXJzX29uZV9nZXQiLCJkcml2ZXJzX3Bvc3QiLCJkcml2ZXJzX29uZV9wYXRjaCIsImRyaXZlcnNfb25lX2RlbGV0ZSIsImRyaXZlcnNfYWNjZXNzX3Bvc3QiLCJkcml2ZXJzX2FjY2Vzc19kZWxldGUiLCJsaW5rc19kcml2ZXJzX3RvX29iamVjdHNfcG9zdCIsImxpbmtzX2F1dG9tYXRvbnNfdG9fb2JqZWN0c19wb3N0IiwibGlua3NfYWN0aW9uc190b19vYmplY3RzX3Bvc3QiLCJnZW9mZW5jZXNfZ2V0IiwiZ2VvZmVuY2VzX29uZV9nZXQiLCJnZW9mZW5jZXNfcG9zdCIsImdlb2ZlbmNlc19vbmVfcGF0Y2giLCJnZW9mZW5jZXNfb25lX2RlbGV0ZSIsImdlb2ZlbmNlc19hY2Nlc3NfcG9zdCIsImdlb2ZlbmNlc19hY2Nlc3NfZGVsZXRlIiwiZ2VvZmVuY2VzX29iamVjdHNfb25lX2dlb2ZlbmNlc19nZXQiLCJnZW9mZW5jZXNfb2JqZWN0c19vbmVfZ2VvZmVuY2VzX2dlb2ZlbmNlX3dhdGNoX3Bvc3QiLCJnZW9mZW5jZXNfb2JqZWN0c19vbmVfZ2VvZmVuY2VzX2dlb2ZlbmNlX3Vud2F0Y2hfcG9zdCIsInNoYXBlc19nZXQiLCJzaGFwZXNfb25lX2dldCIsIm1lc3NhZ2VzX2dldCIsIm1lc3NhZ2VzX3Bvc3QiLCJtZXNzYWdlc19yZWFkX29uZV9wYXRjaCIsIm1lc3NhZ2VzX2NsZWFyX2RlbGV0ZSIsIm1lc3NhZ2VzX2hpc3RvcnlfZ2V0IiwibWVzc2FnZXNfaGlzdG9yeV9ib3VuZHNfZ2V0IiwiZmlsZXNfZ2V0IiwiZmlsZXNfb25lX2dldCIsImZpbGVzX3Bvc3QiLCJmaWxlc19vbmVfZGVsZXRlIiwidXNlcnNfZ2V0IiwidXNlcnNfb25lX2dldCIsImdyb3Vwc19nZXQiLCJncm91cHNfb25lX2dldCIsInVzZXJzX29uZV90b2tlbnNfZ2V0IiwidXNlcnNfdG9rZW5zX3Bvc3QiLCJ1c2Vyc19vbmVfdG9rZW5zX3Rlc3RfcG9zdCIsInVzZXJzX29uZV90b2tlbnNfZGVsZXRlIiwidXNlcnNfYmlsbGluZ19wcmljZV9jb25maWdfZ2V0IiwidXNlcnNfdG9rZW5zX2dldCIsImNvbW1vbl9nZW9fcmV2ZXJzZV9nZXQiLCJjb21tb25fZ2VvX3JvdXRlX2dldCIsImNvbmZpZ19jb25maWciLCJjb25zb2xlX2xlZ2FjeV9zZWNyZXRzX2dldCIsImNvbnNvbGVfbGVnYWN5X3NlY3JldHNfb25lX2dldCIsImxpbmtzX2xpbmtzIiwibW9kZWxzX3dlYl9tb2RlbHNfd2ViIiwibW9kZWxzX3YzX21vZGVscyIsIm1vZGVsc192M19lZGl0b3IiLCJvYmplY3RzX3ZpZXdfbWFwIiwib2JqZWN0c192aWV3X3RhYmxlIiwib2JqZWN0c19ib3RzX29iamVjdHNfb25lX2JvdF9zdGFydF9wb3N0Iiwib2JqZWN0c19ib3RzX29iamVjdHNfb25lX2JvdF9zdG9wX3Bvc3QiLCJvYmplY3RzX2JvdHNfb2JqZWN0c19vbmVfYm90X3N0YXRlX3Bvc3QiLCJvYmplY3RzX2JvdHNfb2JqZWN0c19vbmVfYm90X2NvbmZpZ19wb3N0Iiwib2JqZWN0c19ib3RzX29iamVjdHNfb25lX2JvdF9nZW9fc3RhcnRfcG9zdCIsIm9iamVjdHNfYm90c19vYmplY3RzX29uZV9ib3RfZ2VvX3BhdXNlX3Bvc3QiLCJvYmplY3RzX2JvdHNfb2JqZWN0c19vbmVfYm90X2dlb19zdG9wX3Bvc3QiLCJjaGFpbnNfdjJfZ2V0IiwiY2hhaW5zX3YyX29uZV9nZXQiLCJjaGFpbnNfb2JqZWN0c19jaGFpbnNfZ2V0IiwiY2hhaW5zX29iamVjdHNfb25lX2NoYWluc19nZXQiLCJjaGFpbnNfb2JqZWN0c19vbmVfY2hhaW5zX2NvbnRhaW5lcl9wb3N0IiwiY2hhaW5zX29iamVjdHNfb25lX2NoYWluc19jb250YWluZXJfcGF0Y2giLCJjaGFpbnNfb2JqZWN0c19vbmVfY2hhaW5zX2NvbnRhaW5lcl9kZWxldGUiLCJjaGFpbnNfb2JqZWN0c19vbmVfcHJvY2Vzc2luZ19zdGFydF9wb3N0IiwiY2hhaW5zX29iamVjdHNfb25lX3Byb2Nlc3Npbmdfc3RvcF9wb3N0IiwibG9naWNfdjJfbG9naWMiXSwiaWF0IjoxNTg0ODA5OTc2LCJleHAiOjE1ODczMjk5OTl9.K2bQlUhMfc45J4EkAJFLY3yvXAzBUSGQCWucihovWmk"
    }
    
    func loadUsers(result: @escaping ((Result<[RightechModel], Error>) -> Void)) {
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: Constants.users) else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue(Constants.bearer, forHTTPHeaderField: "Authorization")
        let dataTask = session.dataTask(with: request) {
            [weak self] data, response, e in
            
            print(data, response, e)
            guard let data = data else {
                return
            }
            if case .success(let models) =  self?.mapResult(data) {
                result(.success(models))
            }
        }
        
        dataTask.resume()
    }
    
    private func mapResult(_ data: Data) -> Result<[RightechModel], Error> {
        let decoder = JSONDecoder()
        return Result { try decoder.decode([RightechModel].self, from: data)}.mapError {
            e -> Error in
            
            print(e)
            return e
        }
    }
}