Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A599CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7384D222B0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCXOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:38:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCXOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:38:26 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h84GW-0002Kr-IX; Sun, 24 Mar 2019 15:38:24 +0100
Date:   Sun, 24 Mar 2019 15:38:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or
Subject: Re: [PATCH 1/6] x86, mm: remove second argument of
 split_mem_range()
In-Reply-To: <20190212021215.13247-2-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1903241533140.1798@nanos.tec.linutronix.de>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com> <20190212021215.13247-2-richardw.yang@linux.intel.com>
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

Wei,

On Tue, 12 Feb 2019, Wei Yang wrote:

Vs. the subject line. 'x86, mm:' is not the proper prefix.

# git log path/to/file

gives you usually a pretty good hint, i.e. in this case: 'x86/mm:'

Also the sentence after the colon starts with an upper case letter. So the
full subject would be:

 x86/mm: Remove ......

Other than that. This looks good.

Thanks,

	tglx
