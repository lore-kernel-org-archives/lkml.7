Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8920880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfDOOCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:02:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45464 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDOOCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:02:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4FDCB281628
Subject: Re: [PATCH v4 1/2] platform/chrome: wilco_ec: Fix documentation for
 debugfs raw attribute
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, alevkoy@chromium.org, keithshort@chromium.org
References: <20190412181443.239166-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5ddf74d5-5536-68bc-d8ee-e0c92f7dcb72@collabora.com>
Date:   Mon, 15 Apr 2019 16:02:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412181443.239166-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 12/4/19 20:14, Nick Crews wrote:
> In a previous refactor [repo chrome-platform, branch for-next,
> commit 9cced499d6fdb60434ffa94f8f4b5087ad35802b
> ("platform/chrome: wilco_ec: Standardize mailbox interface")], the
> documentation for the raw debugfs attribute became incorrect, but I
> forgot to fix it. This patch fixes it, as well as de-duplicates
> the documentation by removing it from the source file header comment.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  Documentation/ABI/testing/debugfs-wilco-ec | 32 ++++++++++++++--------
>  drivers/platform/chrome/wilco_ec/debugfs.c | 27 +-----------------
>  2 files changed, 22 insertions(+), 37 deletions(-)

I'm going to squash this commit and queue for 5.2.

Thanks,
 Enric

