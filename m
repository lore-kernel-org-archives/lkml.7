Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD889C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788972086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZnD/c6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbfHOWP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:15:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHOWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JSn/G2Oy/FEQuWnzNZ5SW7BflOV+7FNEUWnKN4qTV8o=; b=CZnD/c6lx99rtJ5klCe9PqogQ
        ijPThQc2FBWmVtYxTy5kSEWa0oKbBuvT5Iii7Ky+NstSfLmOty7W2Ip8XkYXAQglBeeY7KsfZadpa
        sZEQw40B93sR1nApKujoUOAnILefYgrB6bff7NLpOcJi3YShA1MDPdlpUFJpyt8rPAzH290TqPDMC
        0ntpVTbLYaSLOlrXbzmT6ZV5CGr3JnOTtjVcCXvHX/6bdiOqYFwZttk0L8ARJT0DrPQ94Ahjv45pe
        clOMD3/4ThGYL3HtbiIUbkBAkRbjRFqAppuLj2XsIKNYLozH0fQpEt+/SwWzLhey1yOPigMz7D88C
        SeJKC6niQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyO1Y-0007yN-A5; Thu, 15 Aug 2019 22:15:12 +0000
Subject: Re: [PATCH v2] Documentation/admin-guide: Embargoed hardware security
 issues
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Tyler Hicks <tyhicks@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>
References: <20190725130113.GA12932@kroah.com>
 <20190815212505.GC12041@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <635f5f3d-dc1e-90a0-8d85-d26a786bb910@infradead.org>
Date:   Thu, 15 Aug 2019 15:15:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815212505.GC12041@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 2:25 PM, Greg Kroah-Hartman wrote:
> v2: updated list of people with document from Jiri as I had the old one
>     grammer tweaks based on Jon's review
>     moved document to Documentation/process/

If you get to do a v3, you can change the $Subject also.

-- 
~Randy
