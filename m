Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E952086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406111AbfHIKoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:44:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:6052 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHIKoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:44:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 03:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="176788402"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 09 Aug 2019 03:44:16 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>, Pawel Laszczak <pawell@cadence.com>,
        Pavel Machek <pavel@denx.de>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
In-Reply-To: <3fce07ee-5e69-58a9-58f6-750f60b66296@ti.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com> <20190721190335.GA19831@xo-6d-61-c0.localdomain> <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com> <20190722114839.GA10515@kroah.com> <20190722115644.GA12069@amd> <20190722210021.GA25235@amd> <BYAPR07MB470966850323EE3003B3097ADDC70@BYAPR07MB4709.namprd07.prod.outlook.com> <93b4a702-227b-0410-a414-76873088ad72@ti.com> <BYAPR07MB47095895491CFD211EE9E051DDD70@BYAPR07MB4709.namprd07.prod.outlook.com> <3fce07ee-5e69-58a9-58f6-750f60b66296@ti.com>
Date:   Fri, 09 Aug 2019 13:44:15 +0300
Message-ID: <87wofmty80.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> It allows me for testing some functionality using only single board 
>> and even with lacking right cable for proper otg detection. 
>> 
>> So, removing this can cause that testing some functionality 
>> will  be limited on my boards.
>> 
>> If you rely want to remove this, maybe we could do this 
>> after putting this driver to kernel ?.  
>
> I don't want you to remove the user based role change functionality.
> I'm just asking to rely on role switch framework for that and not debugfs.

I agree with Roger. Use role switch framework for production, not debugfs.

-- 
balbi
