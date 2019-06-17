Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D58AC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D9420861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfFQMj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:39:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:39:26 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MkpOZ-1iL19m1NHz-00mJjL; Mon, 17 Jun 2019 14:39:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thomas Lim <Thomas.Lim@amd.com>,
        Eric Yang <eric.yang2@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: include missing linux/delay.h
Date:   Mon, 17 Jun 2019 14:38:55 +0200
Message-Id: <20190617123915.926526-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r3X+Mcq4GDZ3qYDRz2Ihhnt91TQ2U5GxOpABsFsYrkC/K9q9h5n
 iCNKaLTm4verJxBR2gbf1xeYHX3t8DdWTTAtUV2POtlSaUwtwRKQpa/71TAsiTm5UPIGKjd
 J+/kRqcTWmqyST8H4wUAR9xdOfp8NF8rU2uoLqYwzwxpz1WNbRaP7oI+RNniNHlcacXAddZ
 P3NzvMWZ/HEnTZr5TlA8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gIkHZ7VzfnU=:BghEa7Q00cCOgUdn2Xy4TN
 ntd/ikOW70/jka68RwgFFOvVsWZe0SRnkOLrlD6m4vvpa3mNH+WGlAgiV0rWs/pb9jlCNt6Xt
 zE9ZQPtlwXqbvFfCpQXJ8rrIxLEZdSMoVZGxQo3PKYGstUbVA4Hagc6jwbt19jS+sR9+i22DZ
 yCU3d+eWNpaKdQ+mvAPkyc3kf6izzC8ErJR9OrGqIElMTaBQkPrvWIe9OPByQNtAqWEu22oc4
 qG36PmJKAKH0jZTIah0v3v5BrAtsPWJrAt5IinFummsUJyxnzK58ju/9NufZpCShKrNIClbx9
 7a/iR6RBWMwuXvhy+k2e0pp60ApueRRa10iwdjfxhsJattT1IwM+kfth+3L+eEOPIf0WiKc9S
 AJtgCNdEPKgMYVQOi9mopZuEDH3P5gv3xJkpKmmo7WOizDK+D3SlibAmM+NZr+wl7pGwOAEWh
 PsCgN1fGOBExJV3NwJb2/ORp6y4q5Qtu6uR3p85vmBmMeDwDzUnZCoJxfZ8avsSGBZUbQoq+L
 GB6gtPOZbWDlpLUNaFXDkiy5ikcQDsDY5Cfz/LEBCBG6w0C0oP6h/jVVufGzzzsV0Lx0eW2oy
 VlrL1mwfeJjmn4ndivGszp8rsuL/QQdgWY7l0VaUQQNUjorzSPlkQIoaoeVED018PHS1MLrTE
 Xr2FQ0iQU0XgNykaHZFKfd7naYgIc2gtgju13fhBusm6aIiduAolLzigm2zWIz9s/4d2i4xXq
 QQgxMyA193iIPTvQhRBv/3vIdQgooZVG0reFQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some randconfig builds fail to compile the dcn10 code because of
a missing declaration:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function 'dcn10_apply_ctx_for_surface':
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]

Include the appropriate kernel header.

Fixes: 9ed43ef84d9d ("drm/amd/display: Add Underflow Asserts to dc")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1ac9a4f03990..d87ddc7de9c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -22,6 +22,7 @@
  * Authors: AMD
  *
  */
+#include <linux/delay.h>
 
 #include <linux/delay.h>
 #include "dm_services.h"
-- 
2.20.0

