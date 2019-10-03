Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73415C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5077420700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfJCIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:22:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40481 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfJCIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:22:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iFwNe-0003sm-7R; Thu, 03 Oct 2019 08:22:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.or
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/amd/display: fix spelling mistake AUTHENICATED -> AUTHENTICATED
Date:   Thu,  3 Oct 2019 09:22:32 +0100
Message-Id: <20191003082232.4136-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the macros H1_A45_AUTHENICATED and
D1_A4_AUTHENICATED, fix these by adding the missing T.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h      |  4 ++--
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c   |  4 ++--
 .../drm/amd/display/modules/hdcp/hdcp1_transition.c  | 12 ++++++------
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c  |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
index 402bb7999093..5664bc0b5bd0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
@@ -176,7 +176,7 @@ enum mod_hdcp_hdcp1_state_id {
 	H1_A0_WAIT_FOR_ACTIVE_RX,
 	H1_A1_EXCHANGE_KSVS,
 	H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER,
-	H1_A45_AUTHENICATED,
+	H1_A45_AUTHENTICATED,
 	H1_A8_WAIT_FOR_READY,
 	H1_A9_READ_KSV_LIST,
 	HDCP1_STATE_END = H1_A9_READ_KSV_LIST
@@ -188,7 +188,7 @@ enum mod_hdcp_hdcp1_dp_state_id {
 	D1_A1_EXCHANGE_KSVS,
 	D1_A23_WAIT_FOR_R0_PRIME,
 	D1_A2_COMPUTATIONS_A3_VALIDATE_RX_A5_TEST_FOR_REPEATER,
-	D1_A4_AUTHENICATED,
+	D1_A4_AUTHENTICATED,
 	D1_A6_WAIT_FOR_READY,
 	D1_A7_READ_KSV_LIST,
 	HDCP1_DP_STATE_END = D1_A7_READ_KSV_LIST,
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 9e7302eac299..3db4a7da414f 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -476,7 +476,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_execution(struct mod_hdcp *hdcp,
 		status = computations_validate_rx_test_for_repeater(hdcp,
 				event_ctx, input);
 		break;
-	case H1_A45_AUTHENICATED:
+	case H1_A45_AUTHENTICATED:
 		status = authenticated(hdcp, event_ctx, input);
 		break;
 	case H1_A8_WAIT_FOR_READY:
@@ -513,7 +513,7 @@ extern enum mod_hdcp_status mod_hdcp_hdcp1_dp_execution(struct mod_hdcp *hdcp,
 		status = computations_validate_rx_test_for_repeater(
 				hdcp, event_ctx, input);
 		break;
-	case D1_A4_AUTHENICATED:
+	case D1_A4_AUTHENTICATED:
 		status = authenticated_dp(hdcp, event_ctx, input);
 		break;
 	case D1_A6_WAIT_FOR_READY:
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 1d187809b709..136b8011ff3f 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -81,11 +81,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 			set_state_id(hdcp, output, H1_A8_WAIT_FOR_READY);
 		} else {
 			callback_in_ms(0, output);
-			set_state_id(hdcp, output, H1_A45_AUTHENICATED);
+			set_state_id(hdcp, output, H1_A45_AUTHENTICATED);
 			HDCP_FULL_DDC_TRACE(hdcp);
 		}
 		break;
-	case H1_A45_AUTHENICATED:
+	case H1_A45_AUTHENTICATED:
 		if (input->link_maintenance != PASS) {
 			/* 1A-07: consider invalid ri' a failure */
 			/* 1A-07a: consider read ri' not returned a failure */
@@ -129,7 +129,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_transition(struct mod_hdcp *hdcp,
 			break;
 		}
 		callback_in_ms(0, output);
-		set_state_id(hdcp, output, H1_A45_AUTHENICATED);
+		set_state_id(hdcp, output, H1_A45_AUTHENTICATED);
 		HDCP_FULL_DDC_TRACE(hdcp);
 		break;
 	default:
@@ -224,11 +224,11 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			set_watchdog_in_ms(hdcp, 5000, output);
 			set_state_id(hdcp, output, D1_A6_WAIT_FOR_READY);
 		} else {
-			set_state_id(hdcp, output, D1_A4_AUTHENICATED);
+			set_state_id(hdcp, output, D1_A4_AUTHENTICATED);
 			HDCP_FULL_DDC_TRACE(hdcp);
 		}
 		break;
-	case D1_A4_AUTHENICATED:
+	case D1_A4_AUTHENTICATED:
 		if (input->link_integiry_check != PASS ||
 				input->reauth_request_check != PASS) {
 			/* 1A-07: restart hdcp on a link integrity failure */
@@ -295,7 +295,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		}
-		set_state_id(hdcp, output, D1_A4_AUTHENICATED);
+		set_state_id(hdcp, output, D1_A4_AUTHENTICATED);
 		HDCP_FULL_DDC_TRACE(hdcp);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index d868f556d180..3982ced5f969 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -136,8 +136,8 @@ char *mod_hdcp_state_id_to_str(int32_t id)
 		return "H1_A1_EXCHANGE_KSVS";
 	case H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER:
 		return "H1_A2_COMPUTATIONS_A3_VALIDATE_RX_A6_TEST_FOR_REPEATER";
-	case H1_A45_AUTHENICATED:
-		return "H1_A45_AUTHENICATED";
+	case H1_A45_AUTHENTICATED:
+		return "H1_A45_AUTHENTICATED";
 	case H1_A8_WAIT_FOR_READY:
 		return "H1_A8_WAIT_FOR_READY";
 	case H1_A9_READ_KSV_LIST:
@@ -150,8 +150,8 @@ char *mod_hdcp_state_id_to_str(int32_t id)
 		return "D1_A23_WAIT_FOR_R0_PRIME";
 	case D1_A2_COMPUTATIONS_A3_VALIDATE_RX_A5_TEST_FOR_REPEATER:
 		return "D1_A2_COMPUTATIONS_A3_VALIDATE_RX_A5_TEST_FOR_REPEATER";
-	case D1_A4_AUTHENICATED:
-		return "D1_A4_AUTHENICATED";
+	case D1_A4_AUTHENTICATED:
+		return "D1_A4_AUTHENTICATED";
 	case D1_A6_WAIT_FOR_READY:
 		return "D1_A6_WAIT_FOR_READY";
 	case D1_A7_READ_KSV_LIST:
-- 
2.20.1

