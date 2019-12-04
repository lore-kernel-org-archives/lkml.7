Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B945C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F3720803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="vb+G9Wum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfLDNTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:19:39 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:54280 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:19:39 -0500
Date:   Wed, 04 Dec 2019 13:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1575465577;
        bh=gHM6B7PG2qySjZzODSPy0i995oTNz0kE3fGlQ4Z0q8Y=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=vb+G9WumfBR9iHNw1iEFF6N5vKWziGbNKj+6QpLIIM/TIUqnpEQoRPuZC4eLwJFUq
         TX4VZQDCA6dhBmZLSYH+uKi9cK5sY+kIN5R2m4C6MW02OAYYQIpWEGjmZXmrN3QyoJ
         g6OKt3sH/FMwihxDvqD08N+tT4PGWJeIXxsGw5qA=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Re: was: Fair Pay, continuing the line of thought of "OS" - IS - Interface System.
Message-ID: <ZCegJUiDNVC72nQq6popPcGFpg15McyeZIkfr0rUjWA9MH-TX3QVe5c8KSoHR5VoZnYKkoW24_6s7V1us3zl25zrJC2Pp0IzjxbXJDSGWo0=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Answering also the Internet Explorer debate, should one rather call our typ=
e of systems development, of an IS? Interface System? And rather let actors=
 do their software.

I myself is going to use the term IS from now.

Ywe,
https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q
