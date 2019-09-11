Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA8C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 23:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 23:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfIKXYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 19:24:46 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:50945 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbfIKXYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 19:24:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6E498181D3402;
        Wed, 11 Sep 2019 23:24:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pain99_293c1cbda4f24
X-Filterd-Recvd-Size: 1155
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Sep 2019 23:24:43 +0000 (UTC)
Message-ID: <e81cba27b614966139e7324b96da5e90e67c1d6a.camel@perches.com>
Subject: Re: [PATCH] doc: replace IFF abbreviation  with 'if and only if'
From:   Joe Perches <joe@perches.com>
To:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Wed, 11 Sep 2019 16:24:42 -0700
In-Reply-To: <4450664.oKrbQx5eeJ@harkonnen>
References: <20190907105116.19183-1-federico.vaga@vaga.pv.it>
         <20190910063510.GA4267@infradead.org> <4450664.oKrbQx5eeJ@harkonnen>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 15:17 +0200, Federico Vaga wrote:
> Generally speaking compactness does not bring any value if then the text is 
> unclear or open to interpretation.

It's somewhat difficult to choose between +1 and I agree.


