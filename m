Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A7DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5602064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 07:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5UnhWQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbfJVH3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 03:29:32 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34765 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387723AbfJVH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 03:29:31 -0400
Received: by mail-qt1-f175.google.com with SMTP id e14so5555091qto.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PTLxvi63CZDnAk81X8iobU3vOJsRSiwibKLMi068GiE=;
        b=o5UnhWQcvf2zP/7Oti+G0XAqHAPogzvPf47O4QUrYGiAxclyHr6qcLTkAMARmj1SXz
         1IS+wQI5TN05rGwvtSU5wwudw/wvpTADcVcm6zYwiO1x9+dcHykx+N+ANzgxNG8uCvdA
         NK8G5wb1CQ7vBSjLjgE/CmvhbFMdbv83vKigeO7vUw0lYIapn74Ovd6bRyqB8lKiMeAQ
         kGQwzH7YuhEtkde5fWJFkvZjG1NICLmW+6XoUQjpK+H2t++aXE7dJCFSO6DJEAaXZNsK
         E+B1mZlQHTYxGFGuwhBB0/s2v4/LR+AGLCEZYwyX3TZcRKUE9T072UFPq7rynMtnPMUf
         xRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PTLxvi63CZDnAk81X8iobU3vOJsRSiwibKLMi068GiE=;
        b=kDqGFy9ELIKXR8dFvH9ANCAdfnNRLUJpuMvmlVhEZVCHDsYWeuJjWVtnEbJfm6DBN4
         XIbolZAPJ92lRShOR/zFMAjV1UbgfFS1pw8ZKM4GLOdgjwWejolxKvsDxiQpWA9KwTCQ
         nyiIwC4RkJCi8QRXp7XJPK6jTbHrBEvtSnU/HA5X9gIUsLt2xFk997xglkca6CD2y2ub
         GgTARRas/S42kMHVGJujcqMmgkyo51Z4EtcKXwvpBLe4mE+TZQde25zbc0wZqLb2cyj/
         OwTMAxYIcrWNXDbEv64xetMfpEUrcEdhHCd60/7GoWsjvNVQ5GnGmGxwEKeAlflvXir6
         Sp9g==
X-Gm-Message-State: APjAAAU1eQRWa8WeklHc2s5AcGbJsw4oGk3csyJlwyLuoDBCSt8qDdtg
        bDwU/7P8C8fOhFWxdCvnpcTSlXrRpzZFIvmnuG8O2A==
X-Google-Smtp-Source: APXvYqztmY7U5AHMp+fhrMkHocEL3YplwUW2ZGId0SmBImY4kjAQDtYAbH53ZbD55HDvHbkQcnZ0GV4C/eJWD3Fylco=
X-Received: by 2002:ac8:3408:: with SMTP id u8mr1913901qtb.380.1571729368060;
 Tue, 22 Oct 2019 00:29:28 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Oct 2019 09:29:16 +0200
Message-ID: <CACT4Y+ZMxcvnZnDa=uYyaLQaW5r22vBpXkDuMU=CM2BVzjF_Tg@mail.gmail.com>
Subject: adv748x: missing parens
To:     kieran.bingham@ideasonboard.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Building kernel with clang gives me:

drivers/media/i2c/adv748x/adv748x-afe.c:452:12: warning: operator '?:'
has lower precedence than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]

ret = sdp_clrset(state, ADV748X_SDP_FRP, ADV748X_SDP_FRP_MASK, enable
? ctrl->val - 1 : 0);
#define sdp_clrset(s, r, m, v) sdp_write(s, r, (sdp_read(s, r) & ~m) | v)

This is on linux-next commit a722f75b2923b4fd44c17e7255e822ac48fe85f0
Date:   Tue Oct 22 16:17:17 2019 +1100
    Add linux-next specific files for 20191022

It seems sdp_clrset needs some more parens.
