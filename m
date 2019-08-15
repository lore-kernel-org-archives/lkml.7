Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F2EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253D621721
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565908324;
	bh=Pm9SSHX8IOc2MhchN3WM+xETWq0MBuO2B658YKI1EHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WMCPiCaXdff1JhfIJDi7OH4UVFsKQgX95mto6/ERToOxo+ICYFYO35mF/7xKTuu/A
	 6TmWoNqwF2MuzB8EKnW239QoyHA0yfRXw4TpU9W/33bV16PMbObHZvyxtJR7j6Tc9Z
	 Frmnik13YURcibZ4vD0jQ6Yaff6DH9ASfFwAozCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbfHOWcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733099AbfHOWcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:32:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E34206C1;
        Thu, 15 Aug 2019 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565908321;
        bh=Pm9SSHX8IOc2MhchN3WM+xETWq0MBuO2B658YKI1EHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBc5yABsBxF5YK//taFe5vqEyLpQ/ai7GuuPjeaz5HK8bpczB+OuGgtTAfOwy9b7l
         YiWbqcAI4E+xwjt4WIc/ePP8P94aG7G6c07ZUXSDuS8VVZJwpvcdSSEpiBbfU/hPKD
         6H+L1QkDmiyif1VMePES2jXskgmBsTy5+zxVCRKw=
Date:   Fri, 16 Aug 2019 00:31:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Tyler Hicks <tyhicks@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] Documentation/admin-guide: Embargoed hardware
 security issues
Message-ID: <20190815223159.GB28275@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <20190815212505.GC12041@kroah.com>
 <635f5f3d-dc1e-90a0-8d85-d26a786bb910@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635f5f3d-dc1e-90a0-8d85-d26a786bb910@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:15:11PM -0700, Randy Dunlap wrote:
> On 8/15/19 2:25 PM, Greg Kroah-Hartman wrote:
> > v2: updated list of people with document from Jiri as I had the old one
> >     grammer tweaks based on Jon's review
> >     moved document to Documentation/process/
> 
> If you get to do a v3, you can change the $Subject also.

Doh!
