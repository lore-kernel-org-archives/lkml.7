Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1565C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A533221721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560519579;
	bh=Y9e8BPwQcdb80AN8VW8j1pzpc5iVMsJFKb9NKumFQ4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RTYq/sA9wAYaYeKGZphcPrVeETQlVMS0JQEC0alZPMWUFHIsjHEuXOpQpznZA0MpG
	 wrlZv2XIi8erVxisrsb3/yszLdtVDJ8Mkz8Xi0apGjG4Om55GVcoeGXi0gGMT1M0dG
	 p26dUIIWffDtaYsMLbc9nuU5jBgg70aHNLlXj2iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfFNNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbfFNNjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:39:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50F29208CA;
        Fri, 14 Jun 2019 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560519576;
        bh=Y9e8BPwQcdb80AN8VW8j1pzpc5iVMsJFKb9NKumFQ4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjJOUOh9kLdXl0MqFNsMulbhCS2jVnCY8eJL1zesUaaB//AAddTzkfTi278j7JE9d
         Rk+dXayu8+8z3XxjTfCZ+QixtQ4gykj5aeoWuScfLj0C1B3eGXMUPG8NPQL/8JPWbg
         gqPFubhRWEK3wHmcQrUYSGlAjXy/TlqoiiYgbmpM=
Date:   Fri, 14 Jun 2019 15:39:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/14] scripts: add an script to parse the ABI files
Message-ID: <20190614133933.GA1076@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <196fb3c497546f923bf5d156c3fddbe74a4913bc.1560477540.git.mchehab+samsung@kernel.org>
 <87r27wuwc3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r27wuwc3.fsf@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:31:56PM +0300, Jani Nikula wrote:
> On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> >
> > Add a script to parse the Documentation/ABI files and produce
> > an output with all entries inside an ABI (sub)directory.
> >
> > Right now, it outputs its contents on ReST format. It shouldn't
> > be hard to make it produce other kind of outputs, since the ABI
> > file parser is implemented in separate than the output generator.
> 
> Hum, or just convert the ABI files to rst directly.

And what would that look like?

thanks,

greg k-h
