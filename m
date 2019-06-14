Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C88C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF732133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="ajU78w1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfFNMBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:01:03 -0400
Received: from mail200c50.megamailservers.eu ([91.136.10.210]:53218 "EHLO
        mail193c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727054AbfFNMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:01:02 -0400
X-Authenticated-User: wbauer@tmo.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1560513626;
        bh=HVZyoYyM61MSoHgSx0nqGlz+bAaRv7VaJl1ZVD0l7EQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajU78w1wwJXOsrObkFi8VAXW/WsL43zrnS4Q7KteFPeBY/mMtWffDon6bjG7w11kf
         RNhzXQyl546v0ZkiEi/EDiKYWAC7muILlzoiN3TxCuVFbajvZ+aoCzcw9SquVE6WEo
         0fMOpfWoJ3JuK9PneHum9bTA2fYohVJgQRrJWwL0=
Feedback-ID: wbauer@tmo.at
Received: from linux-lf90.site (217-149-172-93.nat.highway.telekom.at [217.149.172.93])
        (authenticated bits=0)
        by mail193c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id x5EC0NHa004834;
        Fri, 14 Jun 2019 12:00:25 +0000
From:   Wolfgang Bauer <wbauer@tmo.at>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom usage
Date:   Fri, 14 Jun 2019 14:00:13 +0200
Message-ID: <2514994.ymxK7X2f37@linux-lf90.site>
User-Agent: KMail/4.14.10 (Linux/4.12.14-lp151.28.20-default; KDE/4.14.38; x86_64; ; )
In-Reply-To: <CAO-hwJLAiC1o-kZ5epZHtO2GK+zc5x28pYbZH-XsY4yAuBmHWw@mail.gmail.com>
References: <20190611121320.30267-1-nsaenzjulienne@suse.de> <CAO-hwJLAiC1o-kZ5epZHtO2GK+zc5x28pYbZH-XsY4yAuBmHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-RefID: str=0001.0A0B0214.5D038C5A.001F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=PM8hB8iC c=1 sm=1 tr=0 a=G5og7FbuazVw68zQRAv8gg==:117
        a=G5og7FbuazVw68zQRAv8gg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
        a=kj9zAlcOel0A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10
        a=W0sgn5rJMnlEUb_Bpn4A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tested linux-next (20190612) meanwhile as well.
My mouse wheel doesn't work with that kernel, this patch fixes it.

Kind Regards,
Wolfgang

