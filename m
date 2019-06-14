Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76A321537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfFNOOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:14:38 -0400
Received: from ms.lwn.net ([45.79.88.28]:52178 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfFNOOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2EACC2D6;
        Fri, 14 Jun 2019 14:14:37 +0000 (UTC)
Date:   Fri, 14 Jun 2019 08:14:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] scripts: add an script to parse the ABI files
Message-ID: <20190614081436.3f41746b@lwn.net>
In-Reply-To: <87lfy4uuzs.fsf@intel.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <196fb3c497546f923bf5d156c3fddbe74a4913bc.1560477540.git.mchehab+samsung@kernel.org>
        <87r27wuwc3.fsf@intel.com>
        <20190614133933.GA1076@kroah.com>
        <87lfy4uuzs.fsf@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 17:00:55 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Fri, 14 Jun 2019, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jun 14, 2019 at 04:31:56PM +0300, Jani Nikula wrote:  
> >> On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:  
> >> > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> >> >
> >> > Add a script to parse the Documentation/ABI files and produce
> >> > an output with all entries inside an ABI (sub)directory.
> >> >
> >> > Right now, it outputs its contents on ReST format. It shouldn't
> >> > be hard to make it produce other kind of outputs, since the ABI
> >> > file parser is implemented in separate than the output generator.  
> >> 
> >> Hum, or just convert the ABI files to rst directly.  
> >
> > And what would that look like?  
> 
> That pretty much depends on the requirements we want to set on both the
> ABI source files and the generated output. Obviously the requirements
> can be conflicting; might be hard to produce fancy output if the input
> is very limited.

The real question, I guess, is: is there anything else that depends on the
current format of those files?  That could make reformatting them harder.

Otherwise it seems like Jani's fieldlist idea might have some potential.
We could consider a *really* simple preprocessing step if we really wanted
("prepend a colon on relevant lines and join with the following line if
need be") to keep the current format nearly unchanged.

jon
