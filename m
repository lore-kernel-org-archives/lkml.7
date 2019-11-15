Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3718A206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="A+5ysGdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKOK0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:26:38 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:10733 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:26:38 -0500
Date:   Fri, 15 Nov 2019 10:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1573813594;
        bh=k3OJKl6Q//tOkpTFQcDrmzzV/td0BvnBkKsNGaztsuU=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=A+5ysGdrIQUTbmhbZ9Afdc6sDWtmXEBDR2o8cbl5C4PzRyKTlDry8qQ0U3CyDWd5O
         AAfYTmhqTe9kv0rydFYhkstfWuEZQOoHaK0XuK3dv+gBMRGWaGzj7+rHoCUblJp7FL
         lCVwEzIfz4v5DNnVIttwUiSiaEezS2vV8hgvn38U=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: DS-X O.S. (was Fair Pay In Source Available Space)
Message-ID: <nBujHT7ILDMX42b3CjgafB4OdCiYaIioC1XL2XZPPs_8Bjo4807_IFe72nRko6OW82Q_CQYqUEXAtAui7BsVkXqDIcFMrqfLWYiwcHeSUAU=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its been a long discussion on LKML, and the Source Available environment in=
 general. Much critisism of Stallman, and much critisism of lack of behavio=
ural limits.

And technically, things such as 1000hz timers have been much criticised, an=
d I found a 10ms filter in sched.c myself, being absurd as jitter is below =
200uS on a good config, and that has long ago happened with a 10ms(!) filte=
r.

It has been talk about "ricers", who config their kernel with unnecessary o=
ptions, yet defer-pop is enabled in the standard config. (rather ofcourse -=
fno-defer-pop)

And while talk about gods is supposedly not wanted, GNU is an "atheist" ver=
sion of god, that requires no money.

An O.S. fits perfectly to replace false deities, with an economic model. Th=
at is mostly what they became in history.

And ofcourse any acceptable paradigm of reality, to reality itself, should =
be supported.

DS-X O.S. supports all this, and inner loop optimization to the point of a =
looping selfmodfyng JSR (with arguments if CPU supports it).

And could be the ultimate cultural economic model, supporting all good 68er=
 politics up to now. (And replaces cannabis with cider, and el-mopeds, inli=
ne with the same philosophy really.)

(And weekendly pilgrimages to the club is not touched.)

Ready for Society V2? Which means money to developers?

Support and develop for DS-X OS, a direct streaming Unix-Derivative.

https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q
Peace.
Ywe.

