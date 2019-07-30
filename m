Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F79217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfG3UAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:00:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfG3UAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:00:31 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsYIE-0008TC-Rh; Tue, 30 Jul 2019 22:00:18 +0200
Date:   Tue, 30 Jul 2019 22:00:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, bp@alien8.de, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/10] x86/CPU and x86/resctrl: Support pseudo-lock
 regions spanning L2 and L3 cache
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1907302158450.1786@nanos.tec.linutronix.de>
References: <cover.1564504901.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

On Tue, 30 Jul 2019, Reinette Chatre wrote:
> Patches 2 to 8 to the resctrl subsystem are preparing for the new feature
> and should result in no functional change, but some comments do refer to
> the new feature. Support for pseudo-locked regions spanning L2 and L3 cache
> is introduced in patches 9 and 10.
> 
> Your feedback will be greatly appreciated.

I've already skimmed V1 and did not find something horrible, but I want to
hand the deeper review off to Borislav who should return from his well
earned vacation soon.

Thanks,

	tglx
