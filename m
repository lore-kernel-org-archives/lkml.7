Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63078C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E2A2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDIW3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:29:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1777 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfDIW3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 18:29:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 15:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="222026244"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga001.jf.intel.com with ESMTP; 09 Apr 2019 15:29:49 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [RESEND PATCHv3 0/3] Update Stratix10 EDAC Bindings
To:     Borislav Petkov <bp@alien8.de>
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, james.morse@arm.com,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
 <fa5b2837-9cb0-517c-c491-9b5d3ae0a3a5@linux.intel.com>
 <20190409201323.GD6150@zn.tnic>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <f843024e-5f06-a566-7ab4-5c3e03e6ed3f@linux.intel.com>
Date:   Tue, 9 Apr 2019 17:32:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409201323.GD6150@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 4/9/19 3:13 PM, Borislav Petkov wrote:
> On Tue, Apr 09, 2019 at 02:11:58PM -0500, Thor Thayer wrote:
>> If possible, I'd like this series to go through the EDAC tree since future
>> patches will follow this format.
> 
> You know how that works - I need ACKs.
> 

I have ACKs on patches 1 & 3. Patch 2 has a Reviewed-by from Rob Herring 
which was sufficient in the past.

Here are the links to the original ACKs and Reviewed-by.

Patch 1: https://patchwork.codeaurora.org/patch/737155/
Patch 2: https://patchwork.codeaurora.org/patch/757205/
Patch 3: https://patchwork.codeaurora.org/patch/757207/
