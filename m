Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66636C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2927E2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552392135;
	bh=37aoO7sQylW2/1zvp/kiFUjPxX1zAnimK78dIt+s9qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vFFU6Pb4IT8j1gQPsPAoRdoQHLB3fl9qujUnM1NrTBKURofHfHr3QcDGEkk++4JjD
	 k0xdycCA17aM9fCeI6oqWtZElFFlPnJDUaCNChiKYMPLREJbFF+Fb+BFNH/Uc1VzYF
	 C1uorxJlPFVyIw7pM/Xhaug2y+MjRjsqz1cTxQ1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCLMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfCLMCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:02:13 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E7D206BA;
        Tue, 12 Mar 2019 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552392132;
        bh=37aoO7sQylW2/1zvp/kiFUjPxX1zAnimK78dIt+s9qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ct57JQsjWhxN1K7RAg1iNfqBb1kaUX3QP2ZCi3uJdGnfhbReeetBmF9vTDg5NQyIA
         wiW+4i94yIp+rZIDyJx+b0Vtt1w1gifkBsh+C4g+Ssg5u+RPU1pnzVNcRjNTfzjvOC
         NW8zmuIvoeCGty3StDBCJIIR73QBaBAGh33FO1Hw=
Date:   Tue, 12 Mar 2019 05:02:12 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     maowenan <maowenan@huawei.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        jananis37@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead
 of memcmp()
Message-ID: <20190312120212.GA30183@kroah.com>
References: <20190309032600.98732-1-maowenan@huawei.com>
 <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:29:29PM +0800, maowenan wrote:
> ping...
> 
> On 2019/3/9 11:26, Mao Wenan wrote:

What?  You got an automated email from my patch system saying that I can
not do anything with this patch until after 5.1-rc1 is out, due to the
merge window.  Why did that not answer the question ahead of time as to
why this patch was not responded to?

Also, it's only been 3 days, please relax, for a clean-up patch, it can
take weeks before they are reviewed as they are obvious at the bottom of
everyone's priority queue.

so all is good, just wait.

greg k-h
