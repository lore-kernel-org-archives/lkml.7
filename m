Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC592063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCGRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:37:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:61848 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfCGRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:37:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 09:37:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121891938"
Received: from sneftin-mobl1.ger.corp.intel.com (HELO [10.241.228.70]) ([10.241.228.70])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 09:37:13 -0800
Subject: Re: [PATCH] igc: remove unused igc_priv_flags_strings array
To:     David Miller <davem@davemloft.net>, arnd@arndb.de
Cc:     jeffrey.t.kirsher@intel.com, ndesaulniers@google.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190307093014.3293229-1-arnd@arndb.de>
 <20190307.092929.277930617530301779.davem@davemloft.net>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <dbc02b0b-8f85-cdc9-2e8d-9a29adefbf6b@intel.com>
Date:   Thu, 7 Mar 2019 09:37:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190307.092929.277930617530301779.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2019 09:29, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu,  7 Mar 2019 10:29:57 +0100
> 
>> clang points out that the igc_priv_flags_strings[] array is never
>> referenced, aside from being used for calculating its length:
>>
>> drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: error: variable 'igc_priv_flags_strings' is not needed and will not
>>        be emitted [-Werror,-Wunneeded-internal-declaration]
>> static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
>>
>> A similar array is present in several other intel ethernet drivers,
>> but all the others use it in their .get_strings() callback, which
>> igc does not implement (yet).
>>
>> Probably it should be implemented, but as I have no way of testing
>> it, this does the simpler alternative of removing the array to
>> get rid of the warning.
>>
>> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Jeff, I assume you will pick this up.
> 
I've submitted igc: Add support for statistics commit 
7aa2547613233a232b9b2e1942d67da4997e6ad0. This patch in Jeff's Kirsher 
next-queue and used igc_priv_flags_strings.
Thanks,
Sasha
