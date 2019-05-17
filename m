Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06281C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AD320833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfEQHOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:14:49 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59393 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbfEQHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:14:48 -0400
X-IronPort-AV: E=Sophos;i="5.60,479,1549926000"; 
   d="scan'208";a="383575452"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 09:14:46 +0200
Date:   Fri, 17 May 2019 09:14:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        nicolas.palix@imag.fr
Subject: Re: Coccinelle: semantic patch for missing of_node_put
In-Reply-To: <201905171432571474636@zte.com.cn>
Message-ID: <alpine.DEB.2.20.1905170912590.4014@hadrien>
References: 201905090947015772925@zte.com.cn,141163ed-a78b-6d89-e6cd-3442adda7073@web.de <201905171432571474636@zte.com.cn>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.20.1905170913031.4014@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A semantic patch has no access to comments.  The only thing I can see to
do is to use python to interact with some external tools.  For example,
you could write some code to collect the comments in a file and the lines
on which they occur, and then get the comment that most closely precedes
the start of the function.

julia
