Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E10208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567007598;
	bh=6/85+MzB1JJmEyPqfvT2XU196VzVe0Da/hn+nwH94WI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IhrZJyJCgW4sr/hargTVcAznV2K38MxbkAa7XiUrXeg14cxWXxYjvq75qbA0EK3FB
	 AIX5AgPzgdms+lJLXpS0h+ten9sf4MBvkz2Gv9lnfANQ6sHdNL08YAlmpQJ9JhQOBl
	 W645S8Rf7o2ay43SFV3wXLLnj0x5VkUQbriTAHgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1PxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfH1PxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:53:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10A22064A;
        Wed, 28 Aug 2019 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567007596;
        bh=6/85+MzB1JJmEyPqfvT2XU196VzVe0Da/hn+nwH94WI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=InFHVs6MWH1gnWoAc3XBoEGci7TX31v4oYyKXQyASPylb9B/f/f/NKujpijCRB9yq
         HjTQRDEkRzEWeu09eK61jLdk8gHjL+8f9hjsuiCsKEMq2bJqiq8WnI74b34D1FqrK4
         JC/Kvcpz6qgHIa019eKMcbL9hjFJtOnHuSGgbfxA=
Subject: Re: [PATCH v1] sefltest/ima: support appended signatures (modsig)
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <1567005240-12912-1-git-send-email-zohar@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <4a9f9cd3-c550-98e4-1513-14ef161c34c2@kernel.org>
Date:   Wed, 28 Aug 2019 09:53:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567005240-12912-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 9:14 AM, Mimi Zohar wrote:
> In addition to the PE/COFF and IMA xattr signatures, the kexec kernel
> image can be signed with an appended signature, using the same
> scripts/sign-file tool that is used to sign kernel modules.
> 
> This patch adds support for detecting a kernel image signed with an
> appended signature and updates the existing test messages
> appropriately.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---

Thanks Mimi. This commit log looks good. My Ack for the patch
to go through the IMA tree.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
