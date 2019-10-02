Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6BBC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6F821A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJBMDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:03:09 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35039 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:03:09 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N17gw-1i9YkR0zSk-012aQY; Wed, 02 Oct 2019 14:03:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
Date:   Wed,  2 Oct 2019 14:01:25 +0200
Message-Id: <20191002120136.1777161-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iyh+vgBexJi73bPkiI60pHY80NTDCFDTYEIUMn80jY7xmFLFyN1
 lOYL3f+3oMpNTxy5GNVwJ3KsEs68xZViW7fENNgg3Jn5U+V1egRUjVEO1ktCKff0Pvq9jvM
 4GUnHYGOIUtOw3K3Thgb50nUN7iI5JiiL8myJPlaQsN9Bhcd/4wqCRRjdXAaL1TbjWAsBvu
 6OdkBy9ayup/rm6WjvHtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:osAlctbyQR8=:PMoF551m2feK1yVfj5p1si
 0NsF0Vw7jCbM3UjyL2s9+FckHGlfjS2CR5RQ8ZjWJhwRIW19TTs3Fw3o/8QRBcxnadhwrtTJs
 u/bBXHhGLUf9GfY2GQ5YbtfE6Y7lDCTClYdkNAJ8Om7NUJ15ngHT+BeANDCC82sO5P1P7Kqrh
 7Apo4JVc9XpchQly/4+AJ0Aoslcr3xTdDH5crjBlFoaDwiir6YfXa8q/A2NB+y9jW5M7x50XF
 srjEuZqSdlsFcY53m4r47Ckm04Oc6X6P0hzM6HlKXipty1ePvojObDCjOD4A6rOwtGpDymgeZ
 pBJZtnC0J9T4DuvTuqqKWrZu3V2YoQQAnt7Wau0Ilkrn1k599PEbivZl3lDzXMh3rvlY96RiC
 AOKVbfVyiCZp7JCioSHddRzgaQEB9GB7kbhKpSoJm7aHxNQtm3IYJ0uZQney+UIZaeQF2euu9
 YXFAjzM4HyyOrmVMv1aD981VTUfnCH7kdTE68ncoLBAb0fhu3TQrBSZZEuDifhvCNwA1J0twW
 2P/Qby4iOItQ+N35i0xNBN0GglcxPdx7QfPYUbI2ihJK7uCKf3vhi2svF336F5xsnoQF6B2zL
 1g43JHYgF2hPy4ufjpnwOIW1vm7jMUnQnwY6RuCw/yEPlIqH+quLN6685+4nZoZIEOgk7Jc65
 UxSLEC7Z69DRdRNoyAErimL5mBLoTsyLuSIbdAMu9Aigcmnu8+xozb1hJsZWGs+rsqXPILL7e
 w3wNvnPx6deHku0JWxLzCTmFfzWVVjPFMoSWC+xdE1vSuqn0s5+nbd6GGDRxaVRT7IBOycOCh
 BYn334EnghabAFgHkq9Hz/KzKXLfVdhlTgwqF36uo2mh1mUfOsaoYot2aaMLxAFooFvsTN5TR
 ov53b8Y7fCwiurBPSYww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like all the other variants, this one passes invalid
compile-time options with clang after the new code got
merged:

clang: error: unknown argument: '-mpreferred-stack-boundary=4'
scripts/Makefile.build:265: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o' failed

Use the same variant that we have for dcn20 to fix compilation.

Fixes: eced51f9babb ("drm/amd/display: Add hubp block for Renoir (v2)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 8cd9de8b1a7a..ef673bffc241 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -3,7 +3,17 @@
 
 DCN21 = dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
 
-CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
+
+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
+endif
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
 
-- 
2.20.0

