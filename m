Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2804320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfCGKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:35:06 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCGKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:35:06 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mbies-1gWMtr0jzK-00dGhs; Thu, 07 Mar 2019 11:34:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Harmanprit Tatla <Harmanprit.Tatla@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        SivapiriyanKumarasamy <sivapiriyan.kumarasamy@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Bayan Zabihiyan <Bayan.Zabihiyan@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: avoid passing enum as NULL pointer
Date:   Thu,  7 Mar 2019 11:34:29 +0100
Message-Id: <20190307103454.1637485-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pCjZDQjfR9i7ray0JlfRKGU/jikmFyHTIEHQ2rP8x9gyfadNyak
 sX8fbIDdM3uRvDmjga6vVzvY5nipvPQogOVy7F9na0zO88bLJTuAy3vJ8q01DYMZb7Jm0It
 9I7LkoSCAXFTJ9a9zkgkRl8TVDVfaxXoOnHRmUAQc4YKhYEaUL/+lFHAn9LYns3LAlCoA0k
 Qkw8yFUn2T73SPu/z4n5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/PAeGTnAZUc=:c5Qe5F8Vk185Dv7HLyLF+b
 fJy5gyKkPke0hxjuD7SRacHOuItAOKGbQKKSOUaOCcrpNXTCfGASJiwWqFQtKZryWh/pHtNIt
 j+oBaQEv/1Kid6vOskUPlPg/E6LHVwUVcZTq4fcmB+RlFyqB2irRGvA0zjOrrVnUca0ntyac3
 yHNHWhJRwoxCokecZpUwsrmhYG6Xxxy0DASxGuMOvduzcDWIqV5poxHWeYsKloSRnztc+y5az
 bG2SfZ3gx6PXvnarYsMxGtLo54wX4nfxFBItn4xAX+zY3fBl7lxlnfIEjRkAGkW36XnvRHmEz
 uxQZDPZ2hUP24jkoBFzai9FjyF1rBg9WruuSzTnmHgT1SDgQUCGYeVrrrjnyACYjasbNVgQQ+
 zQUA0d9I9sOpEctREXDyf3dlkMzD1PKLHWreLy35QfkpJeEfYFAbFypqS8TN327ihbMRlX9qY
 cLjpAnveditXbd8eQZPo+GeDVDAjHsdHCnqNL2kiljn9nn27SjUuV9RM/mF19FKx4xn3emOJY
 4+A2b6UUegIDijrItQUBQ1JS0tjApYL019xK/XYHlygYpj8ckYn0WhrlwW7TgX8p+hZWxfGeK
 7t8EjdZGtpDdDAi1cH62HoAcdkTjwJayZglSW2W3SlcuhCpxNI+TCj1lN63mhHoPzOBlwSIph
 9J/cKs6HIkKQAbx/3rRSE7dmKWD/OHI/7Frh06en8+wOlRii5l2r6L3WeKv4BVw2fZZFKRwRI
 M2bJKlB8kaiHjo4n8CmMjnCyLkHbmPijciRiCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mod_freesync_build_vrr_infopacket() function uses rather obscure
calling conventions, where an enum is passed in through a pointer,
and a NULL pointer is expected to behave the same way as the zero-value
(TRANSFER_FUNC_UNKNOWN).

Trying to build this with clang results in a warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4601:3: error: expression which evaluates to zero treated
      as a null pointer constant of type 'const enum color_transfer_func *' [-Werror,-Wnon-literal-null-conversion]

Passing it by value instead of by reference makes the code simpler
and more conventional but should not change the behavior at all.

Fixes: c2791297013e ("drm/amd/display: Add color bit info to freesync infoframe")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
 drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 94a84bc57c7a..6f32fe129880 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -724,7 +724,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
 
 static void build_vrr_infopacket_v2(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
-		const enum color_transfer_func *app_tf,
+		const enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
 	unsigned int payload_size = 0;
@@ -732,8 +732,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
 	build_vrr_infopacket_data(vrr, infopacket);
 
-	if (app_tf != NULL)
-		build_vrr_infopacket_fs2_data(*app_tf, infopacket);
+	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
@@ -757,7 +756,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
-		const enum color_transfer_func *app_tf,
+		const enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
 	/* SPD info packet for FreeSync
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 4222e403b151..645793b924cf 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
-		const enum color_transfer_func *app_tf,
+		const enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket);
 
 void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
-- 
2.20.0

