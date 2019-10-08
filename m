Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B919EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AAB20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfJHGNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:13:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:64914 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfJHGNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:13:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 23:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="206578422"
Received: from wpross-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.86])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2019 23:13:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mat King <mathewk@google.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, rafael@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
In-Reply-To: <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com> <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan> <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com> <87h84q9pcj.fsf@intel.com> <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com> <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com> <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
Date:   Tue, 08 Oct 2019 09:13:51 +0300
Message-ID: <87sgo3dasg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019, Mat King <mathewk@google.com> wrote:
> That makes sense; just to confirm can a property be added or removed
> after the connector is registered?

You need to create the property before registering the drm device. You
can attach/detach the property later, but I should think you know by the
time you're registering the connector whether it supports the privacy
screen or not.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
