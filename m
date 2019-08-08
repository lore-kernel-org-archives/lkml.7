Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B312084D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565265394;
	bh=Anl8ipdVnvpFxYj8S10CY1unBn01inBb8NEMwE7VAIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZuN/N52kSCeFH1sl41LbrmqAwOAjGdEo4K1ezDlnyaSYF6C/ItvYdfABYeRxzdS+b
	 hvPgVuD1sXxn1NQljo5x1sYfeo2KhSdCG0hskWpDXaHTPIhtJtUQZTatjo0UI7T/jB
	 wpJP7IH0tAEAYO6m+BWczttKbeShc7o3BuZNTej0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfHHL4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfHHL4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:56:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF7C2084D;
        Thu,  8 Aug 2019 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565265392;
        bh=Anl8ipdVnvpFxYj8S10CY1unBn01inBb8NEMwE7VAIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clOUDmP4ZVjbOa059z8EY+tisU0Vz5TTmDJ9dFKvu3PFlMukiCUkKomrwAidGzwDA
         PjCh5tdImv/o4Ppxn4OwCQ/KrIOV4fugdxnANxCtqZ0NZGb3Z96KDWtTiZcp+DTPBX
         KgA5Sshajrm3XD3ff66d0IzaNM/TdSOhc8SMwf8I=
Date:   Thu, 8 Aug 2019 13:56:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     amit@kernel.org, mst@redhat.com, arnd@arndb.de,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio_ring: packed ring: fix
 virtqueue_detach_unused_buf
Message-ID: <20190808115630.GB2015@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
 <20190808113606.19504-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808113606.19504-3-pagupta@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 05:06:06PM +0530, Pankaj Gupta wrote:
> This patch makes packed ring code compatible with split ring in function
> 'virtqueue_detach_unused_buf_*'.

What does that mean?  What does this "fix"?

thanks,

greg k-h
