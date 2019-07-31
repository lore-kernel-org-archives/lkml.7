Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316BEC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D70208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564576128;
	bh=WtyBFMdBR353vI3+5UJCR8oWiGoLewqTegg0gZO6II4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oQKoAbP4OgtLJkejdJHxE8ciAWcNHi+lB9m+7XeYQUgVH930JFufv0o4xhXc883lS
	 Snr7C36D2qRFtKHyFH8xlzKMdTlyLQwgjf7IeREE/EGfSmobZVBZouTdoZ7Xv+djn+
	 I40GhPTU6uynj4KjMw7OE5dODQ/a3slEf4HW5pjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfGaM2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbfGaM2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:28:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1214520693;
        Wed, 31 Jul 2019 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564576125;
        bh=WtyBFMdBR353vI3+5UJCR8oWiGoLewqTegg0gZO6II4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2aMgXFP0ZY1mOmQf7hJZaphxi/bpCIlRWLjK7TyPXfN188tjBSPAewFIV1Zp7qhG
         8+mbZq0QfXLHBhFl+DZ3IZc9bdVaRNvyM9EO8p6V+C0wUcnyGr9/qaoq3BaZZgl2RI
         izCUxP6+4FP2lwiZEAZGdMNVzp9T4C3smXHIQqCk=
Date:   Wed, 31 Jul 2019 14:28:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/11] firmware: arm_scpi: convert platform driver to use
 dev_groups
Message-ID: <20190731122843.GA27960@kroah.com>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-5-gregkh@linuxfoundation.org>
 <20190704091025.GA10622@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704091025.GA10622@e107155-lin>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:10:26AM +0100, Sudeep Holla wrote:
> On Thu, Jul 04, 2019 at 10:46:10AM +0200, Greg Kroah-Hartman wrote:
> > Platform drivers now have the option to have the platform core create
> > and remove any needed sysfs attribute files.  So take advantage of that
> > and do not register "by hand" a sysfs group of attributes.
> > 
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> Assuming you plan to take this series as a whole,
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks, there will be one more series, but ideally we can take the whole
thing as-is.

greg k-h
