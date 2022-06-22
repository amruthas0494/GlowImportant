//
//  URLBuilder.swift
//  HAICA
//
//  Created by Nidhishree  on 06/05/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
class URLBuilder {
    static func endPointUrl(ofAPI api: Router) -> String {
        switch api {
        case .login: return "/api/v1/auth/login/mobile"
        case .logOut: return "/api/v1/auth/logout"
        case .forgotPassword(email: ): return "/api/v1/auth/forgot_password"
        case .educationLessons: return "/api/v1/education_lessons/list"
        case .lessonUnits(let lessonId): return "/api/v1/education_lessons/\(lessonId)/units"
        case .addReview(let lessonId, _, _, _): return "/api/v1/education_lessons/\(lessonId)/review"
        case .addFavourite(let lessonId): return "/api/v1/education_lessons/\(lessonId)/favourite"
        case .removeFavourites(let lessonId): return "/api/v1/education_lessons/\(lessonId)/favourite"
        case .addReflectionJournal(let lessonId, _, _, _): return "/api/v1/education_lessons/\(lessonId)/journal"
       // case .addReflectionJournal(let lessonId, _, _): return "/api/v1/education_lessons/\(lessonId)/journal"
       // case .updateReflectionJournal(let lessonId, let journalId,_,_):
          
        case .addComments(let lessonId, _): return "/api/v1/education_lessons/\(lessonId)/comments"
        case .getComments(let lessonId): return "/api/v1/education_lessons/\(lessonId)/comments"
        case .lessonsByCategory(_): return "/api/v1/education_lessons/list"
        case .lessonsByTab(_): return "/api/v1/education_lessons/list"
        case .favourites(let userId): return "/api/v1/users/\(userId)/favourites"
        case .getAllReflectionJournal(let userId): return "/api/v1/users/\(userId)/journals"
        case .getReflectionJournal(let lessonId, _): return "/api/v1/education_lessons/\(lessonId)/journal"
        case .getRecentSearches: return "/api/v1/users/search/recent"
        case .deleteRecentSearch(let searchId): return "/api/v1/users/search/recent/\(searchId)"
        case .createRecentSearch(_): return "/api/v1/users/search/recent"
        case .search(_): return "/api/v1/users/search"
        case .lessonDetail(let lessonId): return "/api/v1/education_lessons/\(lessonId)"
        case .users(let userId, _, _, _, _): return "/api/v1/users/\(userId)"
        case .onboardingStatus(_): return "/api/v1/users/onboarding"
        case .onboardingProgress(_, _, _): return "/api/v1/users/onboarding"
        case .resendOTP(_): return "/api/v1/auth/signup/resend_otp"
        case .unitStartEnd(let lessonId, _, _): return "/api/v1/education_lessons/\(lessonId)/tasks"
        case .previousStep(let botId): return "/api/v1/bots/\(botId)/previous_steps"
        case .currentStep(let botId): return "/api/v1/bots/\(botId)/current_step"
        case .getStepById(let stepId):  return "/api/v1/bots/steps/\(stepId)"
        case .submitBotResponse(let botId, _, _, _, _): return "/api/v1/bots/\(botId)/submit_response"
        case .bots(_, _, _): return "/api/v1/bots"
        case .bookmarksList: return "/api/v1/education_lessons/bookmarks/list"
        case .moduleSummary(let lessonId): return "/api/v1/education_lessons/\(lessonId)/module_summary"
        case .getFAQTopics: return "/api/v1/bots/faq_bot_id/steps"
        case .previewNextStep(let botId,_, _, _):  return "/api/v1/bots/\(botId)/preview_next"
        case .getInAppNotifications(let userId,_,_): return "/api/v1/notifications"
        case .putReadNotifications(let notificationId, _): return
            "/api/v1/notifications/\(notificationId)"
        }
    }
}
