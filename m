Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F4C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991B2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfKZP5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:57:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:50130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKZP5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:57:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 07:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="202757364"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2019 07:57:46 -0800
Subject: Re: [PATCH v5 0/4] usb: xhci: Add support for Renesas USB controllers
To:     Vinod Koul <vkoul@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191106083843.1718437-1-vkoul@kernel.org>
 <20191121045457.GH82508@vkoul-mobl>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <deaa3d5c-e11d-2194-27f8-3a75435d3027@linux.intel.com>
Date:   Tue, 26 Nov 2019 17:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121045457.GH82508@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2019 6.54, Vinod Koul wrote:
> On 06-11-19, 14:08, Vinod Koul wrote:
>> This series add support for Renesas USB controllers uPD720201 and uPD720202.
>> These require firmware to be loaded and in case devices have ROM those can
>> also be programmed if empty. If ROM is programmed, it runs from ROM as well.
>>
>> This includes two patches from Christian which supported these controllers
>> w/o ROM and later my patches for ROM support and multiple firmware versions.
> 
> Greg, Mathias
> 
> Any feedback on this?
> 

I need to take a fresh look at this series, there is a lot of code.

-Mathias
