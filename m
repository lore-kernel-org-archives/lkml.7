Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669EEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38829218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="MnjdLnXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDRWAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:00:03 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:53959 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDRWAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=QaPr/kZVDrfwGzZX8F6jOM3IY5uw/rAVMAyKjxv9cSg=;
        b=MnjdLnXFuNI7MHAFz8twCMYYDC9De1lWGji4oOMV+YKXXGQ096+gzdxczhZWm7TacApEurOONRJBSzB5YDy8LgsYtuyoky/cpc+5BmKCFNSguzF+MYYeTGaecF4uL9aUSzkBeNp3gYCEeogKvS+1oqB3h1svZX89sebpm24FOAHdXjHJuB4W4+jOSf+ohi5u/WI1Hw4Gifincd5o0RkgAEJs860BHKU0yigHTnWTr/36MIq69zlB8yt+s9ZDJ8nJqQsVGDvQkvPgUtbI+UpPw0Rh+oGPn3USPvCeOPIfeeAc3JAbiJia2uRCfDSLgiWUrPJ8FnZsFNo4OxcIuk1MIA==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=34430)
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <harald@skogtun.org>)
        id 1hHF4Y-0008Lf-Cx; Thu, 18 Apr 2019 23:59:58 +0200
Subject: Re: [REGRESSION 5.0.x] Windows XP broken on KVM
To:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
References: <s5hy347pxtf.wl-tiwai@suse.de>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <5293d178-d6f2-d598-90e6-7f48b6c883f1@skogtun.org>
Date:   Thu, 18 Apr 2019 23:59:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5hy347pxtf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai [18.04.2019 09:38]:

> Hi,
> 
> we've got a regression report on the recent 5.0.x kernel, starting
> from 5.0.6, where Windows XP can't boot on KVM any longer.

Not for all configurations. I just checked with 5.0.8, and Windows XP
boots just fine on KVM.
-- 
Hilsen Harald

