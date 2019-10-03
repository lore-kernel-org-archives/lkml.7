Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C57C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E02921D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570088485;
	bh=L5t/2/pM7csmNlK5vE2ZgW7sWb2o73UBRKM7rDIbdNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWhlH44jbs8tTre78aVShrUOAxywxBeWB+RFhYqhVZaQ8BGbvlPhK35HSTEZKtt7T
	 5yp0u67mzbabTcWJMnE/1KRFDv1Y+TNNOlxvhkEJQCghDCJZmv6/0GTwV27rZaq2vj
	 mbA9BHUgf6rs8kjtAVGyAkEEWIFmuGxn4CctLD44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfJCHlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfJCHlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:41:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B0820873;
        Thu,  3 Oct 2019 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570088482;
        bh=L5t/2/pM7csmNlK5vE2ZgW7sWb2o73UBRKM7rDIbdNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VomR1vITC9UurWPaxDpqDCHgZTZ3FCxpnNdjN6jR1rPyKh1bSXFTPXtkYfCUNGedk
         B2ZS1icIppuzCvPfPhNYJ9F0Bj2ttZnRN6sv/rrBSdY/n89RSu1yiU2uzGAg6q4wIS
         PQ8Nao8uSloV197hSCPVq4HBEz2S5S2WyJAwHEes=
Date:   Thu, 3 Oct 2019 09:41:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-5.3.y] Versions in stable.git and stable-rc.git
Message-ID: <20191003074119.GA1815771@kroah.com>
References: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:38:27AM +0200, Sedat Dilek wrote:
> Hi Greg,
> 
> I see two commits with "Linux 5.3.2" - in [1] it is tagged but there
> is a second one in [2] - both in stable.git.
> 
> In stable-rc.git I see a commit "Linux 5.3.4-rc1" and there was no
> v5.3.3 released before.
> 
> Can you look at this?

Known issue, please see the announcement I made where I messed this all
up:
	https://lore.kernel.org/lkml/20191001070738.GC2893807@kroah.com/

thanks,

greg k-h
