Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F6FC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55219217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557466677;
	bh=9SxKlwKnRueCbd6NZcNmhuNg8tsA7y8WA+UCqE/CVL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5He7YoUaufvlKQPorSZNcxTn0qG5OGix/mby7D9HQmRJN5BcqokKb9nlCp3DozyP
	 o7NyWfkt9GYBXVzO7+0143wMorPBH5bnmk77uOqpEgwnAyQTpNjVtGQFjjS279hfzD
	 ThJdLk8IsdbSymg7dtLsUW2uXIl2RgrBAtuT1DPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfEJFh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfEJFh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:37:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B10921479;
        Fri, 10 May 2019 05:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557466675;
        bh=9SxKlwKnRueCbd6NZcNmhuNg8tsA7y8WA+UCqE/CVL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsGKDcVlmnP1hAg49QVXnjRheBxNPWXqLLx5OqrudNEwGnyZRhan/4f3v9dgqdwOv
         gMXohdYbGpchyC4XoSPJrvT2SR/Pl37IkI3Lkoh5sq3wF3DHDvLnIfNi9gLQCIwFqO
         vTSipACLBYeo+wXVkVM8+WhPBD4Zv81PSajlYqX4=
Date:   Fri, 10 May 2019 07:37:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quoc Tran <qtran@marvell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Quinn Tran <qutran@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [EXT] [PATCH 4.19 60/66] scsi: qla2xxx: Fix device staying in
 blocked state
Message-ID: <20190510053753.GA8481@kroah.com>
References: <20190509181301.719249738@linuxfoundation.org>
 <20190509181307.754166157@linuxfoundation.org>
 <MWHPR18MB1552A7E447C11875F5FDD31FA0330@MWHPR18MB1552.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR18MB1552A7E447C11875F5FDD31FA0330@MWHPR18MB1552.namprd18.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 08:28:29PM +0000, Quoc Tran wrote:
> Hi All,
> 
> Please, remove Quoc Tran (qtran@marvell.com) from this email.  I think the correct contact is Quinn Tran (qutran@marvell.com)

I can't go back and rewrite git history, sorry.

greg k-h
