Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D3C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6652168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568199638;
	bh=6CkPkTexnyeUrJ/816Xs3QnneqgRrUamwtCeRc3RdDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oD3vlvJ/CmON3dWvaAGEbyu9lRaHU9y/bic+/1ImEoHG1ZcLTXdtINjDyYgLl0Njd
	 IxXAgQU1eB26ra0qbfC4cYRG/3DU6YXUm5NGKs/S1VsJEXehVSQZ3V5NJyAuAPL/Ts
	 PoQvi2aw1NMZFHOozaAeilEcijsBG+NJZsooqmiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfIKLAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfIKLAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:00:37 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11BE820CC7;
        Wed, 11 Sep 2019 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568199636;
        bh=6CkPkTexnyeUrJ/816Xs3QnneqgRrUamwtCeRc3RdDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsyuQay4M3D0T6k12JN9vA6vAC8zi/uNCkurc567Yfsj5mi0QNuV4KF18EBKu0XLb
         /K76WGe50DO8+dtS04M61v++esDJbSgw5DaP3GtQqnFE7G5KQzhWZnt3GSzKdMBYdK
         GF2qwcjLTfnYc8QYeHUWCUQaTKLgD9KR6p7FqwVY=
Date:   Wed, 11 Sep 2019 06:11:55 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, ben@decadent.org.uk,
        tglx@linutronix.de, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 2/4] Documentation/process: describe relaxing disclosing
 party NDAs
Message-ID: <20190911101155.GN2012@sasha-vm>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
 <20190910172649.74639177@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190910172649.74639177@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:26:49AM -0700, Dave Hansen wrote:
>
>From: Dave Hansen <dave.hansen@linux.intel.com>
>
>Hardware companies like Intel have lots of information which they
>want to disclose to some folks but not others.  Non-disclosure
>agreements are a tool of choice for helping to ensure that the
>flow of information is controlled.
>
>But, they have caused problems in mitigation development.  It
>can be hard for individual developers employed by companies to
>figure out how they can participate, especially if their
>employer is under an NDA.
>
>To make this easier for developers, make it clear to disclosing
>parties that they are expected to give permission for individuals
>to participate in mitigation efforts.
>
>Cc: Jonathan Corbet <corbet@lwn.net>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Sasha Levin <sashal@kernel.org>
>Cc: Ben Hutchings <ben@decadent.org.uk>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Laura Abbott <labbott@redhat.com>
>Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>Cc: Trilok Soni <tsoni@codeaurora.org>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Tony Luck <tony.luck@intel.com>
>Cc: linux-doc@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Acked-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>---
>
> b/Documentation/process/embargoed-hardware-issues.rst |    7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff -puN Documentation/process/embargoed-hardware-issues.rst~hw-sec-0 Documentation/process/embargoed-hardware-issues.rst
>--- a/Documentation/process/embargoed-hardware-issues.rst~hw-sec-0	2019-09-10 08:39:02.835488131 -0700
>+++ b/Documentation/process/embargoed-hardware-issues.rst	2019-09-10 08:39:02.838488131 -0700
>@@ -74,6 +74,13 @@ unable to enter into any non-disclosure
> is aware of the sensitive nature of such issues and offers a Memorandum of
> Understanding instead.
>
>+Disclosing parties may have shared information about an issue under a
>+non-disclosure agreement with third parties.  In order to ensure that
>+these agreements do not interfere with the mitigation development
>+process, the disclosing party must provide explicit permission to
>+participate to any response team members affected by a non-disclosure
>+agreement.  Disclosing parties must resolve requests to do so in a
>+timely manner.

Can giving the permission be made explicitly along with the disclosure?
If it's disclosed with Microsoft under NDA, it makes it tricky for me to
participate in the "response team" context here unless premission is
given to do so.

--
Thanks,
Sasha
