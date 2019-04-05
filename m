Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C469C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C782146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfDESui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:50:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDESui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:50:38 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCTv9-0002U6-R3; Fri, 05 Apr 2019 20:50:36 +0200
Date:   Fri, 5 Apr 2019 20:50:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Brown, Len" <len.brown@intel.com>
cc:     Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 09/14] thermal/x86_pkg_temp_thermal: Support
 multi-die/package
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C9485C5D6F18@FMSMSX126.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1904052050080.1802@nanos.tec.linutronix.de>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com> <863054888eb8f1a595369c49ec24740501e9c175.1551160674.git.len.brown@intel.com> <alpine.DEB.2.21.1904052027280.1802@nanos.tec.linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C9485C5D6F18@FMSMSX126.amr.corp.intel.com>
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

Len,

On Fri, 5 Apr 2019, Brown, Len wrote:
> > please add a new helper function topology_max_dies() and retrieve it from that.
> 
> I'll do this for Rui -- since his patch is in my x86 branch,
> and it is already (very early) Saturday morning for him:-)
> 
> FYI, there were a couple of other small changes I made to that branch
> in response to list feedback that I pushed, but didn't re-email out the series.
> 
> Thomas,
> Let me know if you prefer me to re-email the series, or just send a git pull request.

Mail is fine.

Thanks,

	tglx
