Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894BCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B642064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfDPR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:27:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:39624 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDPR1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:27:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AF2CF537;
        Tue, 16 Apr 2019 17:27:24 +0000 (UTC)
Date:   Tue, 16 Apr 2019 11:27:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: [PATCH 10/57] docs: device-mapper: convert it to ReST format
Message-ID: <20190416112723.66b4bd4a@lwn.net>
In-Reply-To: <20190416154858.GB22497@redhat.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <9dd3c4eca01489bd67ea6de88dfedef8b0e81901.1555382110.git.mchehab+samsung@kernel.org>
        <20190416132851.GA22497@redhat.com>
        <20190416080024.7fb65682@lwn.net>
        <20190416154858.GB22497@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 11:48:59 -0400
Mike Snitzer <snitzer@redhat.com> wrote:

> Think the last piece I'm missing is: how does one edit a .rst document
> without having to know to sprinkle syntactic sugar around?  Does emacs
> have a ReST mode?  If not what client interface are people using to
> properly change these documents?

There is an RST mode for Emacs, yes.  But you likely don't really need
it.  RST is a simple format and, in general, we try to keep the markup to
a minimum so that the plain-text files remain as readable as possible.
Most of our documents are 99% RST before anybody gets around to formally
converting them.

> (apologies if this is all spelled out nicely in Documentation/
> somewhere, but please help this man learn to fish).

Basics in Documentation/doc-guide (or
https://www.kernel.org/doc/html/latest/doc-guide/index.html).  There's
also some history and overview in:

	https://lwn.net/Articles/692704/
	https://lwn.net/Articles/692705/

Thanks,

jon
