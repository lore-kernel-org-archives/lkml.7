Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D2C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AF220862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="WVWZ2K6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfJFSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:41:46 -0400
Received: from vern.gendns.com ([98.142.107.122]:43106 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfJFSlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8lAJFEkwl2Q1Fvmq3UOLVFJ2OXdPmm/TVkvNTIF5e4w=; b=WVWZ2K6mbb454aWFA0kF4Y10pG
        aLeY5X8WJQxJCsJC/9FFiDqtcHJ4LkNq5KpTo/PdReBUis0fO1xAnkayWrmyW6vOqLTvcryjo9acg
        r+6yIB7v/uo3ynAJ+4gax3yoSysPuZET2PBL//gYy7oppDZiiuTrLxIAqrvcBZtXqPSiRRbFrK5Ue
        BNGlzk1TFhqPmgwEFRKPvCpCTekpG7DwK9NrvWN2eOxDq4BiEuWfqfRsYnWfVRqv5sZ9w+JR2GEyU
        lLd/PcUC+cHc1Z3k3v8ep12hFXdcPuyO5nBA+ez923v4+9EtPutpL/wWcWiv+NGZOktRCzOkA3Reg
        ryRP6+AQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54564 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1iHBTT-00024a-L0; Sun, 06 Oct 2019 14:41:43 -0400
Subject: Re: [PATCH v4 2/2] docs: driver-api: generic-counter: Update Count
 and Signal data types
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org
References: <cover.1570377521.git.vilhelm.gray@gmail.com>
 <75a9ca9837f4d66cb4912cfa535176e27f7c219a.1570377521.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <9850a671-2822-24b7-3c22-b4abbd6a6b37@lechnology.com>
Date:   Sun, 6 Oct 2019 13:41:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <75a9ca9837f4d66cb4912cfa535176e27f7c219a.1570377521.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/19 11:03 AM, William Breathitt Gray wrote:
> Count data is now always represented as an unsigned integer, while
> Signal data is either SIGNAL_LOW or SIGNAL_HIGH.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   Documentation/driver-api/generic-counter.rst | 22 +++++++-------------
>   1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index 8382f01a53e3..161652fc1025 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -39,10 +39,7 @@ There are three core components to a counter:
>   COUNT
>   -----
>   A Count represents the count data for a set of Signals. The Generic
> -Counter interface provides the following available count data types:
> -
> -* COUNT_POSITION:
> -  Unsigned integer value representing position.
> +Counter interface represents the count data as an unsigned integer.

The previous patch looks like it is using unsigned long instead of
unsigned integer.


