Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05FCC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E2420672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKVQxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:53:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:35043 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKVQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:53:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="201578209"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2019 08:53:00 -0800
Subject: Re: [PATCH] xhci: Increase STS_HALT timeout in xhci_suspend()
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "Atroshko, Yevhen" <Yevhen.Atroshko@amd.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20191104055217.10475-1-kai.heng.feng@canonical.com>
 <34F5BCC9-18EE-466D-BBAF-B3D3C1CD525B@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <032e9537-1a84-9e01-20f8-9cd9e394ca3d@linux.intel.com>
Date:   Fri, 22 Nov 2019 18:54:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <34F5BCC9-18EE-466D-BBAF-B3D3C1CD525B@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2019 18.36, Kai-Heng Feng wrote:
> Hi Matthias,
> 
>> On Nov 4, 2019, at 13:52, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>> I've recently observed failed xHCI suspend attempt on AMD Raven Ridge
>> system:
>> kernel: xhci_hcd 0000:04:00.4: WARN: xHC CMD_RUN timeout
>> kernel: PM: suspend_common(): xhci_pci_suspend+0x0/0xd0 returns -110
>> kernel: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -110
>> kernel: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns -110
>> kernel: PM: Device 0000:04:00.4 failed to suspend async: error -110
>>
>> Similar to commit ac343366846a ("xhci: Increase STS_SAVE timeout in
>> xhci_suspend()") we also need to increase the HALT timeout to make it be
>> able to suspend again.
> 
> Seems like there are more broken AMD xHCI in the wild, so please merge this patch if there's no further concerns.
> 
> Kai-Heng

Added to queue,

-Mathias
