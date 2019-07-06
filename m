Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4224C468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4FA20828
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="HQzIhk8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGFOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 10:33:09 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:49732 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfGFOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 10:33:08 -0400
Date:   Sat, 06 Jul 2019 14:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1562423586;
        bh=haA5wvB0xh+dZtWZGeuep4dEUXcEIlBy0xdSwX483iI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=HQzIhk8PxKYt36ErbKPrQMJqON9fHmTQ3PYtYZqeFvsD1zSHVwbkoGWN0bzw7aR8K
         ARMyt0tMl0YH2vDYzZbyJiNYKRjCOTq+GXhhio/qQiJlEQqHfHCkqYGRG+bPNFvlhE
         1q+18riMHNgpRcuVQ6PozQhMO2ct7zAiMwLG2T2M=
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH v5 00/12] S.A.R.A. a new stacked LSM
Message-ID: <HJktY5gtjje4zNNpxEQx_tBd_TRDsjz0-7kL29cMNXFvB_t6KSgOHHXFQef04GQFqCi1Ie3oZFh9DS9_m-70pJtnunZ2XS0UlGxXwK9UcYo=@protonmail.ch>
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 6, 2019 10:54 AM, Salvatore Mesoraca <s.mesoraca16@gmail.=
com> wrote:

> S.A.R.A. is meant to be stacked but it needs cred blobs and the procattr
> interface, so I temporarily implemented those parts in a way that won't
> be acceptable for upstream, but it works for now. I know that there
> is some ongoing work to make cred blobs and procattr stackable, as soon
> as the new interfaces will be available I'll reimplement the involved
> parts.

I thought all stacking pieces for minor LSM were merged in Linux 5.1.
Is there still something missing or is this comment out-fo-date?

Jordan
