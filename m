Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11421C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49772073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCLeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:34:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:39293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCLeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:34:15 -0500
Received: from orion.localdomain ([77.7.27.156]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWiUg-1iIHL13jiq-00X2i4; Tue, 03 Dec 2019 12:33:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: x86: boot.rst: fix typo
Date:   Tue,  3 Dec 2019 12:33:14 +0100
Message-Id: <20191203113314.26810-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:QxB0yf2as5WCetsBr+VpD/b2bYAF6dQCnpK5foDaYJb1/7+LuIx
 3MgUMr1QmARwUT7XxQRfdsTz8KRKvc9lxyndIItiqZSWLhtzPuKq0PqLvFkMHyqrN0B0u5d
 NaQog3AQaoxAT4p5TOUbdaWNLjQh8T+sWai313p9+Pk0x0fETjel8+1Vlo2yV/Z5SkqARop
 eiG5/A5sS5rez4TK1STgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xRge+8Jnbnc=:PmymP6USEjsafLxZVqoRM/
 aAuuBkP769FgvibDItfosmIbwi5CTnh30G8w5w83S21mYNJWb1Dgx3aw56xUhZsRS0XbKmv+y
 ikwrIfFYwaG7PTB0CQO6Bb4On/gd5IpGbKLfCMivb4VEIv7Z+mYjeKkRTfW5LXVbNXG6/RRkV
 ffqxyq3up0yjpUTMFA6wWQ/e2kqu5wtFOQ71pd0za/LNqgOt1OZMu86eqEQffArwOkrtv5B2Q
 aRgiQEsg/g5i/IVM1apTPvkfKMwgeK+AABHtJ5WeB52FKUHkXQmh1h2THw5AARZEIaq8YO7I0
 P2qKcY/On5Y51WregiBfUEx1uuIKNkPwvL+IdTHGEV8x0u8/mX2M4LMox4BYsLXXNSSgx2tG8
 gPoddnPP8h5eBTG/baXLT70ba1onMrZzIf4uljbJbGVbom9pfFaN/8Zpxahjj4Q4gRIkD50E4
 tmaP9JD/epf2v7LJdHoBdA0lxt3ugr5yNEJwlK6N9c7G0vJPtrnRHle03w1FL33fRlkn8WLoH
 +DQyYx7cxeRP2dS+r8O6OV4CiAfx8IpVocwFe3ravZLmNhwFak5AQG4KV6BtvrhOEchn+LHwi
 J7YoC47kEh1P10YeFt4zYogVp9axHFqq5nZq50r3WBMve7OA9ByHO3DPyQZklEmHttgDR6f29
 0jnE9J1BvTI911nz6iaZRaai4r4tOtWkTcBLl2PbGv9bHMmDQPkyumurvYRZQ/H0ddJdpVM+X
 X1DZ4SQkLAGrLIJPN/hhhCChFalHEBCppMHzcdr/0d8RM92Jx2R9bO4tbMgapU4UGgvFXPyi/
 a5n/kDAyRUiy6y/SBUI4EG3y+xKyEvmQJFDOwYP9ty3EcfIZVuKgEOJq+5Ktd7T/5APrw9u0k
 vJ+vr/2qLdpgoV6+oCRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a little typo in the text - it supposed to be "Header Fields",
instead of "Harder Fileds".

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 Documentation/x86/boot.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 90bb8f5ab384..692ce57ac140 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -251,7 +251,7 @@ setting fields in the header, you must make sure only to set fields
 supported by the protocol version in use.
 
 
-Details of Harder Fileds
+Details of Header Fields
 ========================
 
 For each field, some are information from the kernel to the bootloader
-- 
2.11.0

