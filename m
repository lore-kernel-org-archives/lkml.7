Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1031217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="TAxvWLlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfH1JeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:34:19 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:33284 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfH1JeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:34:18 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh23050)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1i2uKp-0003lo-EM; Wed, 28 Aug 2019 17:33:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject; bh=oFsbM+2sxNCiyLL3O7L+BKL+AOPIvK7qg5RwQWkJJng=;
        b=TAxvWLlAPGSnMX/l2uoVntE9RSKf1XwLEkMcN9099KZdDmwtcP/FzB8TT5qi4zK92P/iqgZNwS6Bv4BOkAFSVFLYPIxqUAyDg/L1FC2J0rN+2u4ry+XyFTiyTJWE+uSo4Aer1mYVqXUdpm9fr06dzvOB+GXy/E/XlwniR2OscCs=;
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
From:   Brad Campbell <lists2009@fnarfbargle.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
References: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
 <20190828073302.GO3177@lahna.fi.intel.com>
 <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
Message-ID: <2efea088-fb11-0daf-8c39-f7691e2cf075@fnarfbargle.com>
Date:   Wed, 28 Aug 2019 17:34:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/8/19 5:12 pm, Brad Campbell wrote:
> On 28/8/19 3:33 pm, Mika Westerberg wrote:

>> I'm suspecting that the boot firmware does configure second DP path also
>> and we either fail to discover it properly or the boot firmware fails to
>> set it up.
>>
>> Also if you boot with one monitor connected and then connect another
>> (when the system is up) does it work then?
> 
> Umm.. so this is where it gets weird. No it doesn't. Apparently it fails 
> to configure the first monitor it finds. This is the one the Apple 
> bootcamp firmware configures at boot.
> 

Ok just to clarify it appears I've been booting EFI and bypassing the 
Bootcamp BIOS emulation for a few years. So, that made no difference.

