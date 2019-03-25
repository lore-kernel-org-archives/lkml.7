Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F1420863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfCYQph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:45:37 -0400
Received: from ms.lwn.net ([45.79.88.28]:43266 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfCYQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:45:37 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 24F2E9B1;
        Mon, 25 Mar 2019 16:45:36 +0000 (UTC)
Date:   Mon, 25 Mar 2019 10:45:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v5 1/2] docs: Clarify the usage and sign-off
 requirements for Co-developed-by
Message-ID: <20190325104535.5d98c4ed@lwn.net>
In-Reply-To: <65a633806b819c3067972853a9f1c2b6029e0ce5.camel@perches.com>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
        <20190322211137.18241-2-sean.j.christopherson@intel.com>
        <20190325103114.2df3b91d@lwn.net>
        <65a633806b819c3067972853a9f1c2b6029e0ce5.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 09:40:32 -0700
Joe Perches <joe@perches.com> wrote:

> > I've applied this.  Joe, do you want to handle the checkpatch.pl patch, or
> > would you prefer I take that one too?  
> 
> You taking it is fine with me.
> 
OK, I've now done that, thanks.

jon
