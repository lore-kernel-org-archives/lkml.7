Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E495AC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66EA20828
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfGZBiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 21:38:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:45676 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfGZBiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:38:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 18:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="254171936"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2019 18:38:09 -0700
Date:   Fri, 26 Jul 2019 09:48:52 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 1/2] platform/x86: surfacepro3_button: Fix device check
Message-ID: <20190726014851.GA15416@chenyu-office.sh.intel.com>
References: <20190720150511.95076-1-luzmaximilian@gmail.com>
 <20190720150511.95076-2-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720150511.95076-2-luzmaximilian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 05:05:10PM +0200, Maximilian Luz wrote:
> Do not use the surfacepro3_button driver on newer Microsoft Surface
> models, only use it on the Surface Pro 3 and 4. Newer models (5th, 6th
> and possibly future generations) use the same device as the Surface Pro
> 4 to represent their volume and power buttons (MSHW0040), but their
> actual implementation is significantly different. This patch ensures
> that the surfacepro3_button driver is only used on the Pro 3 and 4
> models, allowing a different driver to bind on other models.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
Acked-by: Chen Yu <yu.c.chen@intel.com>

Thanks,
Chenyu
