Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A808C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0372920873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560863391;
	bh=f9SHC6ue1dvc84vpVLaqwcu3AML1Htt1R+Utuud1GTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oIjM58d86bNDCLScVmo6Q7QdZBPwW7jCDFEYFzRt3a1Z33qQEWywRoUzbO8kvsfNP
	 Al6QMBol4XQiQBu0vSfUORHjJCotV7VxDESzscgzhAlPz/18H/pG8+RTeCjvIhSGWb
	 SbxZTYrkPqE28pPryMpj3rvrinDfjjyCONgupudw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfFRNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRNJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:09:49 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B972084D;
        Tue, 18 Jun 2019 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560863388;
        bh=f9SHC6ue1dvc84vpVLaqwcu3AML1Htt1R+Utuud1GTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPKYFxhGfJdxNynwSUcJvOSB2VvmorxMuALt8f5OBtdiSNMe5kb/Fw86etHgDOW9S
         xnU+h29Vb1rNycsM+/Wy3zybYASLnmCa3xaECrAwDCPoHvW7f8MDvjc+3QaQ2bTO8A
         aMijB6RtLVioPsjacen7t8s5XPORJLq6Aqs6T6ck=
Date:   Tue, 18 Jun 2019 21:08:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: fsl-qdma: Add LS1028A qDMA bindings
Message-ID: <20190618130843.GB1959@dragon>
References: <20190506090344.37784-1-peng.ma@nxp.com>
 <20190506090344.37784-4-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090344.37784-4-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 09:03:44AM +0000, Peng Ma wrote:
> Add LS1028A qDMA controller bindings to fsl-qdma bindings.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

Applied, thanks.
