package api

import (
	"github.com/gofiber/fiber/v2"
	"github.com/sukh-j-14/fingenie-main/internal/handlers/profile"
	"github.com/sukh-j-14/fingenie-main/internal/middleware"
	"gorm.io/gorm"
)

func SetupProfileRoutes(app *fiber.App, db *gorm.DB) {
	// Initialize handlers
	profileHandler := profile.NewHandler(db)

	// Profile routes group
	profileGroup := app.Group("/api/v1/profile")

	// Apply auth middleware to all profile routes
	profileGroup.Use(middleware.AuthMiddleware())

	// User profile routes
	profileGroup.Get("/", profileHandler.GetProfile)
	profileGroup.Put("/", profileHandler.UpdateProfile)

	// Income streams routes
	profileGroup.Post("/income-streams", profileHandler.AddIncomeStream)
	profileGroup.Put("/income-streams/:streamId", profileHandler.UpdateIncomeStream)
	profileGroup.Delete("/income-streams/:streamId", profileHandler.DeleteIncomeStream)
	profileGroup.Get("/user/:phoneNumber", profileHandler.GetUsersByPhoneNumber)
	// Budget routes
	profileGroup.Post("/budgets", profileHandler.CreateBudget)

}
