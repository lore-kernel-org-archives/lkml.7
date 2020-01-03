Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70C5206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578048978;
	bh=frmKFoU2diHTEIxUzsBBFAkYH1ChEP9MGdcBLb9EyJg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MQ+BlgORF2y4THhxnku4wbTgREb+UUphDsllzygbi1NWglDpKMvskX2xCfAigQGGI
	 mGAChtH1RhizCASsibSlb5I5cR5kx7NHxbLgwO5aQ5/wDxITOhi/Aa7kvTNbURcX4r
	 Q2UwFqsjc18VczEaxAXLW/sRsu+PDNFW7nGsrLpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgACK4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgACK4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:56:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF98206DB;
        Fri,  3 Jan 2020 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578048977;
        bh=frmKFoU2diHTEIxUzsBBFAkYH1ChEP9MGdcBLb9EyJg=;
        h=Date:From:To:Cc:Subject:From;
        b=OhoLe+yi0cEvGCcRPhdcTGSYnffN31VXCsqHWBXJTmZSoHhf3NTd4Ygh5xd1ifQKr
         dpN2hWNYZl61TxjWntmxPR1A9esrez9xncHM2zfOiLPcgNMkMBGM6kttKVLd+jXOY3
         +MdkDzwmrg3cA8M7jBHzJjEZeML8yWdz9PHiE0N8=
Date:   Fri, 3 Jan 2020 11:56:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     tech-board-discuss@lists.linuxfoundation.org
Subject: Linux Kernel Code of Conduct Committee: December 2019 report
Message-ID: <20200103105614.GC1047442@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the spirit of getting into a proper cycle for the reports, here's the
end of 2019 status so that we can start fresh with January 2020 and get
on to the normally scheduled report schedule.

Linux Kernel Code of Conduct Committee: December 2019

In the period of December 1, 2019 through December 30, 2019 the Committee
received the following report:
  - Insulting behavior in email: 1

The result of the investigation:
  - Education and coaching: 1

We would like to thank the Linux kernel community members who have supported
the adoption of the Code of Conduct and who continue to uphold the professional
standards of our community.  If you have questions about this report,
please write to <conduct@kernel.org>.

------------

Side-note, the website at https://www.kernel.org/code-of-conduct.html is
now up to date and this, and all future reports will also be published
there.

thanks,

greg k-h
