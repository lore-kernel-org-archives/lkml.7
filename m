Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103EBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D397B21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572027807;
	bh=lLUWKlQSw6cbzfOx3ssw4CYUi+NPKxNn4RqhHEiesBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lbUCJDHcMVg+PpDaonjxycbD8WyT0IdxOHt45JBCiXFr4iV5fi4pGFfeU+WJnNXl4
	 KvotgZZWqPIKNwvHk+UA/3gB4xevxB6E9UCg5/CWiDlj3EBF45cr5nvb4QE0Zekgew
	 jO0tsBO2lVCg8aizlh1DUkF5ZC9CaouL0br8eRgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfJYSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJYSX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:23:26 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04A8321D7F;
        Fri, 25 Oct 2019 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572027806;
        bh=lLUWKlQSw6cbzfOx3ssw4CYUi+NPKxNn4RqhHEiesBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucTsJj1G3pBPc/qY/XwGEJUUh6jlAWOHfUj3edhnIoMnHpchOhy1PrE7ozqZTNFii
         JTGEvWlaWo4sxjaoyB07fYuu+AZCqVvtdgm1tOJNpypBYY6GN3yLkYtSxNkllWAr2X
         pVWj/FbNRXHX87yF94rTpuuwbWIJprwsOSpzNBN4=
Date:   Fri, 25 Oct 2019 11:23:25 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] f2fs: delete duplicate information on sysfs nodes
Message-ID: <20191025182325.GC24183@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191023214821.107615-1-hridya@google.com>
 <edc52873-b40d-5047-dba0-d693548eb16d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc52873-b40d-5047-dba0-d693548eb16d@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24, Chao Yu wrote:
> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> > This patch merges the sysfs node documentation present in
> > Documentation/filesystems/f2fs.txt and
> > Documentation/ABI/testing/sysfs-fs-f2fs
> > and deletes the duplicate information from
> > Documentation/filesystems/f2fs.txt. This is to prevent having to update
> > both files when a new sysfs node is added for f2fs.
> > The patch also makes minor formatting changes to
> > Documentation/ABI/testing/sysfs-fs-f2fs.
> 
> Jaegeuk, any particular reason to add duplicated description on f2fs.txt previously?

Not at all, thus, I asked Hridya to consolidate them. :P

> 
> Thanks,
