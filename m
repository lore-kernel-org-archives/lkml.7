Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98995C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7693E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfKZQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:19:04 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:41601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfKZQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:18:41 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFL8J-1ibaYS3gVd-00Fkok; Tue, 26 Nov 2019 17:18:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 1/8] media: documentation: fix video_event description
Date:   Tue, 26 Nov 2019 17:18:17 +0100
Message-Id: <20191126161824.337724-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191126161824.337724-1-arnd@arndb.de>
References: <20191126161824.337724-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O2/jQz6atdIoPkZzpfDsjDAz//w3xantCbjSR3tAaWYdZ8jpOKh
 ZUgeen38z5h+pLVR5FP6sQ2W/xw/2kHgo6mlLhvRdIMGneVTVk3s0pI6QyXaW2qv2uQPXUI
 T/l9xx+efbp61Juc/JdHbsPaEnWbrZ/fl2HVAoCdsxfKJHSlU/cfJAgPqaldX5DhucvZrz0
 3FGi6Aplfk1ciZMPybeiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oum7zHKWCkI=:HupciVegc8wYBWgevpOL1Q
 o4o4TBM5lxVo017HqjJaX1nkaA9kO8Ofd76KplJuR7e8O6edx6yffyfE/FTMIzdhLA5viYexn
 kqjbqddnPEoMc2Gnp5kLbZl/Hpl2VN/TgrY0pyw0ZgHy1EkmIV6SjjM38tqsMDwzgUF8yR9Ol
 oQx9C5a2xnuWjK1LDLj1AU+JG3MNKl2T77E55SjFJ4Hr5wG06k4WwE0ZzwTBEgVl6ybCLx4SM
 0r75I56TTtJS+DZpFlR5MaPbTu/XVxmB4C0JQuE2Qo1ihI2kMG9BGYXQL2Hrt63GkvWubtSFL
 H7ZRUeSRWkEiw6PUxFCrkNj6Thn7FoAsbUMoiHsu/XuIL8R/VUZ8POqH+azuJwvFq1p4RZuWC
 FB2U9pcIndXbXuY2KmEL8XRnv5wHzzRZ9Tje/T6X6bwmkU0MXJN1vZ0CFiH6RYrYQJILrSUm9
 s0TXrz8TP/O8FRJAs+dNsRug3SpSjDYDRZRsoNQKFqxkxOcYlbVWem5JKjn7+7h7UG4BQqbN8
 jhmFiX/ZhLBOKe20wp6xkKtWFTZPNCeCxq/8DE2UgYxMkQQm4zu3qRuna0Xdvnm8BJ688b8Up
 sOvicaprRhlKAwh156sR62zNd8tyKfVI5Y4TsVvStIGAkin9wVFVmHgPXCSqFSW0Uta++dir8
 OC0/s7y9M0ezWZbC/kTXOFpGEwWq342RI2ljICfd2S9twkNAwScly90jdCL8XWoWlJZ9/Md/c
 NTzzOwNOe5SpdV/VcCzTnnRUWDYUw0m05fEy7+Nm2P9KHE7z0eU6UqX9rIXMI7h+4vx/240tG
 pqDJ0WT7fJf2+tosrVekV/ACcNCvFOglAsWF1Rgkn0hDDHC+S9J+GMo1t6o5sev5lmzS78/fv
 9IRMSUwKjichLMLSMapQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type for the timestamp in video_event was changed to
'long' a long time ago, change the documentation to match.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/media/uapi/dvb/video-get-event.rst | 2 +-
 Documentation/media/uapi/dvb/video_types.rst     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/dvb/video-get-event.rst b/Documentation/media/uapi/dvb/video-get-event.rst
index def6c40db601..7f03fbe3d3b0 100644
--- a/Documentation/media/uapi/dvb/video-get-event.rst
+++ b/Documentation/media/uapi/dvb/video-get-event.rst
@@ -81,7 +81,7 @@ for this ioctl call.
 	#define VIDEO_EVENT_FRAME_RATE_CHANGED	2
 	#define VIDEO_EVENT_DECODER_STOPPED 	3
 	#define VIDEO_EVENT_VSYNC 		4
-		__kernel_time_t timestamp;
+		long timestamp;
 		union {
 			video_size_t size;
 			unsigned int frame_rate;	/* in frames per 1000sec */
diff --git a/Documentation/media/uapi/dvb/video_types.rst b/Documentation/media/uapi/dvb/video_types.rst
index 479942ce6fb8..2697400ccf62 100644
--- a/Documentation/media/uapi/dvb/video_types.rst
+++ b/Documentation/media/uapi/dvb/video_types.rst
@@ -170,7 +170,7 @@ VIDEO_GET_EVENT call.
     #define VIDEO_EVENT_FRAME_RATE_CHANGED  2
     #define VIDEO_EVENT_DECODER_STOPPED     3
     #define VIDEO_EVENT_VSYNC       4
-	__kernel_time_t timestamp;
+	long timestamp;
 	union {
 	    video_size_t size;
 	    unsigned int frame_rate;    /* in frames per 1000sec */
-- 
2.20.0

