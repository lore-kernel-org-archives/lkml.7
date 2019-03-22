Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B88C218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553264421;
	bh=UMIB3lXD76yTMNtoPQ0zryZjLbiS8VRMl7tPzUzWiVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T7O6BHq7iQx5ZQePPw8OD1/Od/X25tZL5unwguJ5L545PwfBN2l80cBNoFAzOl8uT
	 cUH3Rhxq8vCNSSEpIZ/KRbv0sW9n9N22f+sijIdBLcx1bDUAXripVZbQHCoGwdsmTS
	 kpgv2FU5kYU0Jbn/5rPNdR5GV3Fy1DUVHmI16zlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfCVOUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfCVOUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:20:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF760213F2;
        Fri, 22 Mar 2019 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553264419;
        bh=UMIB3lXD76yTMNtoPQ0zryZjLbiS8VRMl7tPzUzWiVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xucf7/+HC2uko0zz2alsx+hzDe43IDyNYQrXOCwghVb58j3JZtWTM0ylestDTxrdm
         jJuBG+GXtI2GOCvy+W0Td3JRiqrdjicFPNpo+kvCWMrNVWrAxoxZSV/t61kr4h+uz4
         cgoeJ8CWNq/jSNbEvQAHfZuI+NQnjMErIROWgsow=
Date:   Fri, 22 Mar 2019 15:20:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mt7621-mmc driver correctness fixes
Message-ID: <20190322142016.GB23722@kroah.com>
References: <20190320224204.10243-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320224204.10243-1-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:42:02PM -0600, George Hilliard wrote:
> This series improves up the patches that needed more work from v2 I sent
> a couple days ago.  BUG_ON()s have been removed.
> 
> Let me know if you don't want the 'Remove obsolete Kconfig flags' patch I sent
> in the previous series; I didn't see any mail about it.

If I didn't apply it already, please resend.

thanks,

greg k-h
