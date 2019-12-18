Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4892072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BsQ8f7yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLRSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:07:13 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:29300 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfLRSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:07:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576692432; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZzjwHNlWTGUeG4psCAxuvjSpl0hRuojeLLO2C+3lNAg=; b=BsQ8f7yJwQFOSYSpp8+Ih8wNIw6V8Djox3ruwxm6ZRTcbhxFnSUjWzXTjMx9DRY8iYHeZ01d
 G5/pYUK+hkUeMMk74UiS5WfTvaUowwzIIeqLg3pdMfO2T3y2pC7ox39cPlwYass63isJ7Kgi
 K34FZEni6FFfenHPSUEYgomlpN8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa6acc.7feb408605e0-smtp-out-n03;
 Wed, 18 Dec 2019 18:07:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67D8BC433A2; Wed, 18 Dec 2019 18:07:08 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BDA4C433CB;
        Wed, 18 Dec 2019 18:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BDA4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] ath11k: Use sizeof_field() instead of FIELD_SIZEOF()
References: <201912180919.2A471217@keescook>
Date:   Wed, 18 Dec 2019 20:07:05 +0200
In-Reply-To: <201912180919.2A471217@keescook> (Kees Cook's message of "Wed, 18
        Dec 2019 09:19:35 -0800")
Message-ID: <87d0cl8q46.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> The FIELD_SIZEOF() macro was redundant, and is being removed from the
> kernel. Since commit c593642c8be0 ("treewide: Use sizeof_field() macro")
> this is one of the last users of the old macro, so replace it.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Please also Cc linux-wireless so that the patchwork sees this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
