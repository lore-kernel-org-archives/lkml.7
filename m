Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD9DC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80461218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbfGWNmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:42:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:48708 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfGWNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:42:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6C22D2C9;
        Tue, 23 Jul 2019 13:42:19 +0000 (UTC)
Date:   Tue, 23 Jul 2019 07:42:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sheriff Esseson <sheriffesseson@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: filesystem: fix "Removed Sysctls" table
Message-ID: <20190723074218.4532737f@lwn.net>
In-Reply-To: <20190723114813.GA14870@localhost>
References: <20190723114813.GA14870@localhost>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 12:48:13 +0100
Sheriff Esseson <sheriffesseson@gmail.com> wrote:

> the "Removed Sysctls" section is a table - bring it alive with ReST.
> 
> Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>

So this appears to be identical to the patch you sent three days ago; is
there a reason why you are sending it again now?

Thanks,

jon
