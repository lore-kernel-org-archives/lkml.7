Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67283C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C60F216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfGHRZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:25:26 -0400
Received: from foss.arm.com ([217.140.110.172]:54422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfGHRZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:25:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2551928;
        Mon,  8 Jul 2019 10:25:25 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217E03F246;
        Mon,  8 Jul 2019 10:25:24 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:25:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: Re: [PATCH 5/6] firmware: arm_scmi: Use the term 'message' instead
 of 'command'
Message-ID: <20190708172522.GB11197@e107155-lin>
References: <20190708154358.16227-1-sudeep.holla@arm.com>
 <20190708154358.16227-6-sudeep.holla@arm.com>
 <a04dfc00-9c7a-8321-859d-7a12e7b84ea6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04dfc00-9c7a-8321-859d-7a12e7b84ea6@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:21:29PM +0100, Steven Price wrote:
> On 08/07/2019 16:43, Sudeep Holla wrote:
> > In preparation to adding support for other two types of messages that
> > SCMI specification mentions, let's replace the term 'command' with the
> > correct term 'message'.
> > 
> > As per the specification the messages are of 3 types:
> > commands(synchronous or asynchronous), delayed responses and notifications.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h | 10 +++++-----
> >  drivers/firmware/arm_scmi/driver.c |  6 +++---
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 44fd4f9404a9..4349d836b392 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -48,11 +48,11 @@ struct scmi_msg_resp_prot_version {
> >  /**
> >   * struct scmi_msg_hdr - Message(Tx/Rx) header
> >   *
> > - * @id: The identifier of the command being sent
> > - * @protocol_id: The identifier of the protocol used to send @id command
> > - * @seq: The token to identify the message. when a message/command returns,
> > - *	the platform returns the whole message header unmodified including
> > - *	the token
> > + * @id: The identifier of the message being sent
> > + * @protocol_id: The identifier of the protocol used to send @id message
> > + * @seq: The token to identify the message. when a message returns, the]
> 
> Stray ']' at the end of the line.
> 

Thanks for spotting, will fix it.

--
Regards,
Sudeep
