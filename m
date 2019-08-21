Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26676C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5C2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfHUMGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:06:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:37621 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfHUMGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:06:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="181010206"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2019 05:06:12 -0700
Subject: Re: [PATCH V5 3/4] PCI: Add Genesys Logic, Inc. Vendor ID
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
References: <20190820020650.8334-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f1975e6e-b7fe-3fb0-bbd9-256462d686c8@intel.com>
Date:   Wed, 21 Aug 2019 15:05:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820020650.8334-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/19 5:06 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add the Genesys Logic, Inc. vendor ID to pci_ids.h.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..4f7e12772a14 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2403,6 +2403,8 @@
>  #define PCI_DEVICE_ID_RDC_R6061		0x6061
>  #define PCI_DEVICE_ID_RDC_D1010		0x1010
>  
> +#define PCI_VENDOR_ID_GLI		0x17a0
> +
>  #define PCI_VENDOR_ID_LENOVO		0x17aa
>  
>  #define PCI_VENDOR_ID_QCOM		0x17cb
> 

