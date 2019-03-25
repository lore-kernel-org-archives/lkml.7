Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E44320863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfCYQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:40:37 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:34794 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbfCYQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:40:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 11201837F24D;
        Mon, 25 Mar 2019 16:40:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beef22_4f023205ee2d
X-Filterd-Recvd-Size: 1686
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 16:40:33 +0000 (UTC)
Message-ID: <65a633806b819c3067972853a9f1c2b6029e0ce5.camel@perches.com>
Subject: Re: [PATCH v5 1/2] docs: Clarify the usage and sign-off
 requirements for Co-developed-by
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Date:   Mon, 25 Mar 2019 09:40:32 -0700
In-Reply-To: <20190325103114.2df3b91d@lwn.net>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
         <20190322211137.18241-2-sean.j.christopherson@intel.com>
         <20190325103114.2df3b91d@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 10:31 -0600, Jonathan Corbet wrote:
> On Fri, 22 Mar 2019 14:11:36 -0700 Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > The documentation for Co-developed-by is a bit light on details,
[]
> I've applied this.  Joe, do you want to handle the checkpatch.pl patch, or
> would you prefer I take that one too?

You taking it is fine with me.


