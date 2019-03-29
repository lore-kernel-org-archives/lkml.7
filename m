Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B73D206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jFD7ISQ0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QcWeBBGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfC2Eir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:38:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfC2Eir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:38:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0BB016086B; Fri, 29 Mar 2019 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553834326;
        bh=a/LWH/FXoeFQ5gx9EpVUMNMimfwbZGLn8yWTHNSoYec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jFD7ISQ0bzf2MTvmLbUVBr2W72ugBkv+j90lOBXvvNq8DZBqGbj2yxkZ4g81fGsEs
         kM0LCbo41ikDjwncIS2LfyS/zmemmYFawVfP7oPVrAUjDIo7X8mnU/N2XiyDX4ra9C
         x67LAz3gQlfykmyZ6H6S8ja6le1/zkBHJJzMgXSQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 52750605A2;
        Fri, 29 Mar 2019 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553834325;
        bh=a/LWH/FXoeFQ5gx9EpVUMNMimfwbZGLn8yWTHNSoYec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QcWeBBGbGB4GoXFpBmLoVS8FPWBA1+w0CDDJJVcx+h9Oabo9vvAPTrOjHXtOEhHwc
         RQYyFGTJPAevvWFzhLenbacqfuN1W55RG7GEVYEl7wBcbv775tou538PgjF5xFM36l
         ehrPLYNBQhWxjFsbdoRNK8Pvh4zfwBKCjwoeFCN8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Mar 2019 10:08:45 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
In-Reply-To: <20190327172905.GE112750@google.com>
References: <1553689723-21017-1-git-send-email-c-hbandi@codeaurora.org>
 <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
 <20190327172905.GE112750@google.com>
Message-ID: <273d6b53cec219cb1c1a3432da331c46@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-03-27 22:59, Matthias Kaehlcke wrote:
> On Wed, Mar 27, 2019 at 05:58:43PM +0530, Harish Bandi wrote:
>> This patch enables regulators for the Qualcomm Bluetooth WCN3998
>> controller.
> 
> I commented on this on v3, but you didn't update it:
> 
>   No, it doesn't.
> 
>   The next version should probably say something like "Add compatible
>   string for the Qualcomm WCN3998 Bluetooth controller".
> 
[Harish] - will take care in next version.
> Thanks
> 
> Matthias


