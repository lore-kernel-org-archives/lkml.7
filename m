Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E8B206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q5zeKyqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfH0MZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:25:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfH0MZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:25:03 -0400
Received: from zn.tnic (p200300EC2F0CD000F02F6C1468024718.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:f02f:6c14:6802:4718])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D65BF1EC04CD;
        Tue, 27 Aug 2019 14:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566908702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s7kPLI4sMUsuslNLP7x5pNq6QoeQeW/FIbkiioxiiXM=;
        b=Q5zeKyqXaNLbKd4hyA7ey+52PKnu177uR5hkozj0WSWUWV2cDzgIsaY7I9Qr6JAmXMQ4Mr
        5GrBSyu0iNMfZ+hSwPZj5fg1YoYIVa59N0r50G5C5aIKYF4wnAZ0wRagbP6VVi9+WylbnH
        96L4jtGEfdmqTd7GPLd3WhhRqSWOOeg=
Date:   Tue, 27 Aug 2019 14:25:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190827122501.GD29752@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <20190826202339.GA49895@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826202339.GA49895@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 01:23:39PM -0700, Raj, Ashok wrote:
> > Cloud customers have expressed discontent as services disappear for a
> > prolonged time. The restriction is that only one core goes through the
> s/one core/one thread of a core/
> 
> > update while other cores are quiesced.
> s/cores/other thread(s) of the core

Changed it to:

"Cloud customers have expressed discontent as services disappear for
a prolonged time. The restriction is that only one core (or only one
thread of a core in the case of an SMT system) goes through the update
while other cores (or respectively, SMT threads) are quiesced."

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
