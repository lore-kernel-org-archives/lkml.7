Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B696C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D443207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfKHHw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:52:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:31142 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfKHHw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:52:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 23:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,280,1569308400"; 
   d="gz'50?scan'50,208,50";a="206393627"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2019 23:52:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iSz4g-0008oU-3G; Fri, 08 Nov 2019 15:52:54 +0800
Date:   Fri, 8 Nov 2019 15:52:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 18/50] microblaze: Add loglvl to microblaze_unwind_inner()
Message-ID: <201911081556.iyEIbDDJ%lkp@intel.com>
References: <20191106030542.868541-19-dima@arista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkkcajgk3glfl4us"
Content-Disposition: inline
In-Reply-To: <20191106030542.868541-19-dima@arista.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkkcajgk3glfl4us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.4-rc6 next-20191107]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/kallsyms-printk-Add-loglvl-to-print_ip_sym/20191108-124037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 847120f859cc45e074204f4cf33c8df069306eb2
config: microblaze-nommu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arch/microblaze/kernel/unwind.c: In function 'unwind_trap':
>> arch/microblaze/kernel/unwind.c:176:2: error: too many arguments to function 'microblaze_unwind_inner'
     microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace, loglvl);
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/microblaze/kernel/unwind.c:154:13: note: declared here
    static void microblaze_unwind_inner(struct task_struct *task,
                ^~~~~~~~~~~~~~~~~~~~~~~
   arch/microblaze/kernel/unwind.c: At top level:
>> arch/microblaze/kernel/unwind.c:191:13: error: conflicting types for 'microblaze_unwind_inner'
    static void microblaze_unwind_inner(struct task_struct *task,
                ^~~~~~~~~~~~~~~~~~~~~~~
   arch/microblaze/kernel/unwind.c:154:13: note: previous declaration of 'microblaze_unwind_inner' was here
    static void microblaze_unwind_inner(struct task_struct *task,
                ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/microblaze/kernel/unwind.c:154:13: warning: 'microblaze_unwind_inner' used but never defined

vim +/microblaze_unwind_inner +176 arch/microblaze/kernel/unwind.c

   153	
 > 154	static void microblaze_unwind_inner(struct task_struct *task,
   155					    unsigned long pc, unsigned long fp,
   156					    unsigned long leaf_return,
   157					    struct stack_trace *trace);
   158	
   159	/**
   160	 * unwind_trap - Unwind through a system trap, that stored previous state
   161	 *		 on the stack.
   162	 */
   163	#ifdef CONFIG_MMU
   164	static inline void unwind_trap(struct task_struct *task, unsigned long pc,
   165					unsigned long fp, struct stack_trace *trace,
   166					const char *loglvl)
   167	{
   168		/* To be implemented */
   169	}
   170	#else
   171	static inline void unwind_trap(struct task_struct *task, unsigned long pc,
   172					unsigned long fp, struct stack_trace *trace,
   173					const char *loglvl)
   174	{
   175		const struct pt_regs *regs = (const struct pt_regs *) fp;
 > 176		microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace, loglvl);
   177	}
   178	#endif
   179	
   180	/**
   181	 * microblaze_unwind_inner - Unwind the stack from the specified point
   182	 * @task  : Task whose stack we are to unwind (may be NULL)
   183	 * @pc    : Program counter from which we start unwinding
   184	 * @fp    : Frame (stack) pointer from which we start unwinding
   185	 * @leaf_return : Value of r15 at pc. If the function is a leaf, this is
   186	 *				  the caller's return address.
   187	 * @trace : Where to store stack backtrace (PC values).
   188	 *	    NULL == print backtrace to kernel log
   189	 * @loglvl : Used for printk log level if (trace == NULL).
   190	 */
 > 191	static void microblaze_unwind_inner(struct task_struct *task,
   192				     unsigned long pc, unsigned long fp,
   193				     unsigned long leaf_return,
   194				     struct stack_trace *trace,
   195				     const char *loglvl)
   196	{
   197		int ofs = 0;
   198	
   199		pr_debug("    Unwinding with PC=%p, FP=%p\n", (void *)pc, (void *)fp);
   200		if (!pc || !fp || (pc & 3) || (fp & 3)) {
   201			pr_debug("    Invalid state for unwind, aborting\n");
   202			return;
   203		}
   204		for (; pc != 0;) {
   205			unsigned long next_fp, next_pc = 0;
   206			unsigned long return_to = pc +  2 * sizeof(unsigned long);
   207			const struct trap_handler_info *handler =
   208				&microblaze_trap_handlers;
   209	
   210			/* Is previous function the HW exception handler? */
   211			if ((return_to >= (unsigned long)&_hw_exception_handler)
   212			    &&(return_to < (unsigned long)&ex_handler_unhandled)) {
   213				/*
   214				 * HW exception handler doesn't save all registers,
   215				 * so we open-code a special case of unwind_trap()
   216				 */
   217	#ifndef CONFIG_MMU
   218				const struct pt_regs *regs =
   219					(const struct pt_regs *) fp;
   220	#endif
   221				printk("%sHW EXCEPTION\n", loglvl);
   222	#ifndef CONFIG_MMU
   223				microblaze_unwind_inner(task, regs->r17 - 4,
   224							fp + EX_HANDLER_STACK_SIZ,
   225							regs->r15, trace, loglvl);
   226	#endif
   227				return;
   228			}
   229	
   230			/* Is previous function a trap handler? */
   231			for (; handler->start_addr; ++handler) {
   232				if ((return_to >= handler->start_addr)
   233				    && (return_to <= handler->end_addr)) {
   234					if (!trace)
   235						printk("%s%s\n", loglvl, handler->trap_name);
   236					unwind_trap(task, pc, fp, trace, loglvl);
   237					return;
   238				}
   239			}
   240			pc -= ofs;
   241	
   242			if (trace) {
   243	#ifdef CONFIG_STACKTRACE
   244				if (trace->skip > 0)
   245					trace->skip--;
   246				else
   247					trace->entries[trace->nr_entries++] = pc;
   248	
   249				if (trace->nr_entries >= trace->max_entries)
   250					break;
   251	#endif
   252			} else {
   253				/* Have we reached userland? */
   254				if (unlikely(pc == task_pt_regs(task)->pc)) {
   255					printk("%s[<%p>] PID %lu [%s]\n",
   256						loglvl, (void *) pc,
   257						(unsigned long) task->pid,
   258						task->comm);
   259					break;
   260				} else
   261					print_ip_sym(loglvl, pc);
   262			}
   263	
   264			/* Stop when we reach anything not part of the kernel */
   265			if (!kernel_text_address(pc))
   266				break;
   267	
   268			if (lookup_prev_stack_frame(fp, pc, leaf_return, &next_fp,
   269						    &next_pc) == 0) {
   270				ofs = sizeof(unsigned long);
   271				pc = next_pc & ~3;
   272				fp = next_fp;
   273				leaf_return = 0;
   274			} else {
   275				pr_debug("    Failed to find previous stack frame\n");
   276				break;
   277			}
   278	
   279			pr_debug("    Next PC=%p, next FP=%p\n",
   280				 (void *)next_pc, (void *)next_fp);
   281		}
   282	}
   283	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--vkkcajgk3glfl4us
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJ0ZxV0AAy5jb25maWcAnDzbcuO2ku/5CpVTtZXUOZPoYnvk3fIDBIISIt4MgLI8LyyN
rZmo4pFckpxk9uu3AZIiQDaknE0lGRvdABp97wY4P/7wY4+8H3ffVsfN8+r19Xvv63q73q+O
65fel83r+n96QdpLUtVjAVe/AHK02b7//eu3zfN+9/l19b/r3s0v17/0P+yfb3vz9X67fu3R
3fbL5us7rLHZbX/48Qf490cY/PYGy+3/u9dM/fCq1/rw9fm599OU0p97H/VSgE7TJOTTgtKC
ywIg99/rIfilWDAheZrcf+xf9/sn3Igk0xOoby0xI7IgMi6mqUqbhSrAIxFJEZOnCSvyhCdc
cRLxTyxoELl4KB5TMW9GJjmPAsVjVrClIpOIFTIVCuDmoFPDvtfeYX18f2vOMhHpnCVFmhQy
zqzVYcuCJYuCiGkR8Zir+9FQs6uiMo0zDhsoJlVvc+htd0e9cIMwYyRgogOvoFFKSVTz5OoK
Gy5IbrPFnK2QJFIWfsBCkkeqmKVSJSRm91c/bXfb9c8nBCLorEjSQj4S62zySS54RjsD+k+q
omY8SyVfFvFDznKGjzZTTifPJYv4BDk0yUFTa2mA9HqH98+H74fj+lsjjSlLmODUCDcT6cTa
1gbJWfroakKQxoQnho719qW3+9Laob0KBV7P2YIlStYkqc239f6AUTX7VGQwKw04tU8KjAUI
DyKGqoAB48rBp7NCMFloZRXSxanI71BzYr9gLM4ULJ8wm5p6fJFGeaKIeEK3rrBsWOkGsvxX
tTr80TvCvr0V0HA4ro6H3ur5efe+PW62Xxt2KE7nBUwoCKUp7MWTqaWoMtCSo0xKDVd+SLEY
2fQrIudSESVxuiVH2fQP6DbnEzTvya5kgfanAmA2IfArOBAQOGa5skS2p8t6fkWSu9VJSefl
D5bazk8ySR294vPSe0jUc2hfEIIF8FDdDz42WsETNQcHEbI2zqit+5LOWFBaQK378vn39cs7
hIHel/Xq+L5fH8xwdSIEarnCqUjzDJeadkoyIyByFAx00HmWAuXaGlQqcEMq6dX+0GyFSeVJ
hhLcIWg3JcqOEm1IsRg6smYRwQ1lEs1h2sIEAhEge0KgSjMwYIhKRZgK7SHgj5gk1DHLNpqE
H/ATOK53koXNL6U2Nr/H4PQ5+FlhnXPKVAwWZBYiUdTmQDPcsNVsWUMQmsIZScC5tT1/6bSs
UaN6dqiylJxFIQRL4bBkQiTwIsf3zBVbNtPNr0XGrQWz1DkdnyYkCgPbJoE8e8B4eXuAcCuw
8rTIhePBSLDgktV8sQ4as3hChOA23+ca5SmW3ZHCkcJp1Bxeq53iC5crWXhGFrA1CwKj2Y1P
pIP+dceTV8lett5/2e2/rbbP6x77c70Fn0jAmqn2ihBYbPP+hzNqUhZxydLCOH9HFXRaRBTk
VJY6yIhMHLWL8glu5lGKpQ16PrBeTFmd77irATSEoBZxCV4EFDaN8dVneRhCxpYRWAh4DKkW
OBwUNY5JZlAe3dzTE1DTkEegQGh4cpPOkyJxCrlNRD65ngIi6kSLOgk4STCPAwgRVwpOUeI0
TP4EyUARxKSbLs0eGWQbqgsAReMTAT4R2ApOEEGQeWyJURE6VwJ8eSHzLEttf6QjCbhYC2DU
K3tdHbVG9XZvuuI4NGEXPCKcBASXJ1TpHLiaEay/bLYbg9yDmb2GUVb1MWciYVFpSCQIxH3/
77t++U+NstQSWVp87hchiXn0dH/152Z/XP99c3UGFTxrEUsBrl8qcT+4gJnROPuHqNp7sOgi
WsAXF3FmjzoK3A8voIVZfhYHloF64/7q4y+D/i8vV43idmRXSnS/e14fDiCZ4/e3Mt2y8oUm
Wx70+7Zmw8jwpo+nwp+KUd8LgnX6iCHMPt0DxDbYvOMGJzv4raN4NA6AByCJNLWcczV6f/UM
yLvX9f3x+D2P+v8eDG6G/f5VezKEcWpFRcmo9nt2CniOT7aT7jIvEdrMJcj/dDqIRzqpCEwe
kSayc1SwmtX7qxnQCW9pOquXP7Unf+k921V/zZHear/uvR/WL83O4O4gwJn8BCxq1LIoyGty
Euk0jUHizij4TsDqt2wSnASYf9celclMypXHNawdf1wOTd4PvbQtvozySottbtuoTqm/2j//
vjmun/WyH17Wb4APYa2rFTOyYMBd48mxijPQcQPSDhC1yq1C2pTXulsBboyYJFWyaQyhsYUy
Gk64KtIwLCyI2ZRG8xbuI4HIqovxjAgw4LpJ0O6PGHcMFCsjiroYrIWVBnkE5aX2ADoB0+mG
la9Ny+ZIBFEc0puhQ1B9pJm1Y6SDywT2eyQikKMGcnutz6UTrk4KUB65BYL4BUUxC0NOuU4g
wlC6yXhoUopOblgKlaaLD59XoLO9P0qFedvvvmxendL0JBGNXcVmVtSJbx2Uz6x0YlKUT3li
OiuU3l99/de/rrpR/YJ+1WsJBb4a8lhmZUomeslYUzZoic1mSTlUehywUIIVIhVOnmi4d3IJ
xvOdNKjUDC/TqnWgzj31plz5dDD59BxYqwg4krOblelXzKWE1KqpIwse6wwDn5onoPBgg0/x
JI1wFCV4XOPNdT6O8HNSFcadUnAi8WNZ8FbnC6kmFZsKrs7XnDqbw0WlMeowZBwEnsFqtMcJ
3pnUMGmiCekaWbbaH03+1VMQuGzPC46dKyP7KhzZHCJQ4iUNDrovgdLxPEYqw0trxHxKLuFA
DOIXcGJCcYwaLoNUNhiOMsgAEjQ5h7qDeYwASoYl5MKT8zTINAJCZbEc316gFoqQJbhedmHf
KIgvLCSnlxgD1ZW4KCeZX5L1nIj4kpxYeIkY3Za+HV9AsqwBw6oTspZe/2AZQ/yg84pTYzpt
2l2W/gMST8tGVMBImS5+R4Dzp4lpDzTNvAowCR9Qytz9fmhEnphjyQyikPbdTa+O/b1+fj+u
Pr+uzUVQzxTtR4vWCU/CWBWSCp61UxEdGyt4GBGnlLaGccdRwsEnU6w4TQULcjcN9lFqjhGv
v+3233vxarv6uv6G5mWaFMhJrXYQDEAKETDdiwErzlrplO7QaFZVOM6lRwalc5EpAzYp9p35
59TV4BCmVVpMcitKJymUFkXVAiiDB1vqBnYTtBMGws2YSduLeewU9BEjZWKI8vNTBkUIDpnk
nmYDE3obf5t8mmfFhCV0FhMxR/XNz/bmRKcKPlkf/9rt/4DEqCscCMdz5ihQOQJeikwRBdFe
rOFsbnwkdfhlxtqzm9DtCenLUMQ608UjIRwGipMnhB6euNTzrOyrUuK50gOEUykmUkjo8B0B
LUsyLzE84+eAU+3mWZwvPR4xAUNL59zTUC/XWCjuhYZpjlOtgWTmh0H+5QdCvQI5nYfJRqT2
zSoMKZrVw+5KeZD5VcBgCPJ4AUNDgYlSiRTPs/Tu8GNTWiOUn3BoPuHWXWl951rD76+e3z9v
nq/c1ePgxpcEg3xufeLR99m6n9C13hZONnsyxRV4gjjrNB8bZCh/fHo6yc4AQYkDSj0Sz8Bw
FQ6D+hDnOGiIJ1vD27XR0LPDRPBgit2gmABgxC+Jc0tbDqGLLSKSFOP+cPCAggNGYTZOX0SH
vvQzwmW3HN7gS5EMLxqyWerbnjPGNN03115LN2kHfiyK7xckUjd4Uv0EAec9SIuYCgDP3zOW
LOQjVxT3Iwup79w9kQtIhoRn7jftOPMEAH3YROJbzqQ/LJSUQr3lxYhGkENIsJHiHFZC3btp
CySWOp94Ktw7q8lD1AqwveP6UN2xO0tnczVleEbbmdkC2DHb4geJBQkg50RTaYKn2J5CkoRw
PuGz67CY0xhhyyMXLNIZlJ0ohVOtzINOOXoCbNfrl0PvuOt9XsM5dUb5Ul4QEGoQrES9GtFJ
kmlkwciy6j02Oz5yGMU9WDjnnu6Glsgd7pUo4SEOYNms8HUFkhBnXibBq/telehwG+Kw6FHl
SeIpD0PCo7Rl2VX7+M/N87oX7Dd/OiWPcahlZVTT1fqlenUj0cG6feoCkXtoGGa6qQOWgnMD
psWoiWnIQ87FXLbWA3ud5LgbMUQozxWkBvIUN3UNywSeWRkYkRz3t7NU6Xaixuo2XGDsebc9
7nev+n3Fy0kIpf6vXtb6Ohaw1haafhb09rbbH21/odkIehhA9s9M3xJ1GxdXdA8VKvj/wHNB
oxH0RrWkfUis6tkjmnfYfN0+6rsIzQe6gx+kdbKK5rNopwofZ+SJyWz78rbbbNss0zep5gUK
3jawJ56WOvy1OT7/jovN1bPHKsgoRr3r+1ezF6NE4MolSMZbDr25A9k8V2ZtXaU05VZ5iz9j
UeaJ9xD1VJyFWJMUvGsSkMi5dshEuWLIRWz6VebRYh3qws3+219ahq870MG9VeU/ms62/aqC
LZUgp3X0i8fGjdXYpuY7R32DiTecKxm06Tq1S0wHWrdjndbGiTXgYIpAcF+uVCGwhfDUaiWC
fiBaLQO5VwwOGs+fNRqB8o/WyOZ1JCKY0+19luvdOa0uFOyri65anK7cXkwwcPQkTpeqnYZa
N2/1DCvmpRCEqO91xTSRmELFyr27UIE5dPe2s2nlva32h5bV6WlEfDTdQM8uTsfQft0DoDQ8
jTpLgvwnaaq6yyINxpoqQ1YOP/bine7ula9p1H61PbyWd7HR6rvbY4SdJtEcpNYiq3MjESpP
huIDcC9EhIF3OSnDAPfqMvZOMnxMPQ8CNfDUqWVBlV53ZCxI/KtI41/D19UBXOPvmzfLxdqi
DHlbVL8xqNp8xqERwEBOT4udmbCYLm2wa3YLS78NmhAoVB55oGbFwJVUCzo8C712oXp/PkDG
hshYoiCLXqouhMSB7JqShoDLJj6TAHCueOQuB1LoGILndZWxu4lknjh6Rp5lL3j19qYLlmrQ
pPYGa/Ws31G0LVz7czi95qdufpxRtdmTBCTPqXMKfiBfts9oeFss9KW6532YXjkiEKJi9LSX
TlO+uF2/fvmgg/5qs4ViBtasPCmWTJgdY3pzM/ASFBBFwoh46mCjfXSWDUfz4Q3eftIoUqrh
jd+sZdQ5ssPsc1D47xzYuLih5kInSdwc/viQbj9QzcFOreLyIKXTESqSy9xuObCEJZDgeMnV
TcizCDLjHQRDbpQFgej9V/nnEDLAuPetbMl75F5OwA51eSmEpjM6nU/w6kbDZk+QZrUqtDqR
UVaNl4a2OUE8zROuPF/BAFRf6CjBmL1AwYiInnDQPJ385gzoB4BlN6EZ4+LB+b1s9De/x4H9
ADgNzasmsdDhiMUt8nXF3HoiXueH+jot1m8r60pZR7bq/WOTuZdDyPzqsh97aJDkUaR/wbsx
FZIurKTUhsWz0XCJdzNq5BxOdhYhgpB9FiEQE/+TBEP0Bbhcjv1cqGJNd7B8ZHw/uMVgpqsz
HtzZH2YFEGd034wGC5we8JNGqgVTuK+snknKJ0kono2faLhwZCGX3aI3WcTMqXLbfNRwNLkD
QNHuGNVNP3vRMqRuDs9YNk+Cm+HNsoCiF+/qQaETP2kT8rSkSaI8OYDiYWxqJTwDpfJuNJTX
fTyEsYRGqcyhaNSmyH1fjMyygkd495Jkgbwb94fE0ybmMhre9fujM8Ah3ueAtEamQhYKkG48
71hrnMls8PHjeRRD6F0fN9hZTG9HN/jVQiAHt2McpH0lMK2A1HdUlGM4Db4YbLdC/F811qYR
hO2GRr3MIiOJpxNEh21PWD5nYJnOKpGOVgkBgx3itxwNHL9YqeARmxKKXwRWGDFZ3o4/nl3k
bkSXeN50Qlgur89iQM5fjO9mGZO46Cs0xgb9/jVq5S1WWaydfBz0O7ZXftW4/nt16PHt4bh/
/2Y+6jj8vtpDDnTUlahep/cKOVHvBfzF5k3/aItA6bIBpeX/sa5lq/rikeiKJOu+QePb4/pV
P/2H1Ga/fjVfPDfa0ULRHYgyG6xhkvIQGV5AfHNGT8QApGhlNq1NZrvDsbVcA6Sr/QtGghd/
93Z6HS6PcDr7LcZPNJXxz1Z+e6Ldort+OXSGT5ZW0RnuL/U7HhAE1Z+uUU/ip1GEkksvxoxA
PUsKgn+c6cSgijOS15l3I9PaOQFQv/903gQTDpUlJIK4U5fU810otpGTA+AHxuO5ImLKlD+2
hblsPTwrZc4Y6w1Gd9e9n8LNfv0I//2M+bmQC6avxfC1KyBk7vIJPerZbazbyKYb2Ix1v81L
k8D3nsCkBrjresjNJ1L+y1bFfMUfofoWHo/KmRe0WPogugHq6aJOPW8KgAbpCWhAO/wkU89t
nMpxImC8WBj+ilTKwjN74UtBkyj2vW4V7ScJpSbp+8fG87aukaCEPu43n9+1h5DldQOxnq47
lWd95/IPp5w69mqmPwFRrnYtIKUA/zKiqVNXLSAPYHgQVE/ZLEXf5FrrkYBkijnfTFdD5guU
sGVLyAJT5qo9U4PRYHlhUkSo4LDJzP0AkYPPxupiZ6pi7jNiKC18eVIVHJW8dIiYfLK/DHFA
7vPsOBgPBgNvxZNpnRoNL2wHNp4oTvANBcXHtVqkTj+dqMj3cibCawMNwA1IQ3xMvCTNXKTC
eShUjkAdOx6jX51ZkyciJUFLqSfXeJY6obF2SZ43tckSZwb1aYfi0zTBixi9mO/doFQsbqff
9kSsQ+EeWF8tO+dNsG6yNae6i3baq4Rin/g6kxbc/uzUBs1YJE3npuFSOVQoXHFOYJxfJzAu
uAa8CC8QDXmSQ1fbtpEpIAueOPo3ZfrLgZMnxUNwC9BdOHD9oom9ecSxHrg9S7+9cu43oyHe
fpJ5Eug3k+fXY3EeMaezPmHDi7SzT3TGnWvWcqRIMqm/QAS3rb+uK9rm1F1pmqZT+1M+CzRz
Nphlg0vGPsvJI+PoWnw8vFkucZC+RXCO4ntGwdpfuboQTztlir9ggfEF/hKJL31TAODZ5Nq7
O+6cfosv6EVMxIK5z3/iRex7kCbnU8/fCDJ/uhCtYtiFJKl7uRMtr4v2c7oGduNP8AEqH8+C
w8cL9HAqXH2Yy/HYc59TgmBZ/CpmLj+Nx9edogzfNO2YVEKH499uPRqX0OXwGqA4GFj68Xp0
IbKaXSU4M9Qu4ifh3tnC74O+R84hI1FyYbuEqGqzxumVQ3hqLcej8fCCycOP+u97cjI2OfRo
6WKJvkd2lxNpksa4Q0pc2nkB6/1n3m48uuu7Tn84v6wdyYIH3IlA5kvRoJUldiemc4diwE8v
RLvqyxCWTHnifuA6gywWNBRl7BPTT3BCfqEayFgi9d/7gTL3IUqn7t/a9RCR0dJzXfIQefMu
WHPJksIHfkA/IrAJyXWvJXZSxgdKPoKH1xdz+KJU9wOBQShUxBcVQwTO0cVt//qC5gumyw8n
FRgPRneeTwE0SKW4WYjx4Pbu0magDUSighP6rbhAQZLE/8fYtTU3juPqv+Kap5mq6e3Yjm35
YR9kSbY50S0SHSt5UbkTd8e1SZzKpXb7/PoDUJRMSQCdh56MiY8X8QKCIACCFNLyHclxD+ue
b4icQXBNF4nOmEv41xJXc8Y+F9LLJQ7nmZmZi9Bt8xBvProYD8/laq0Q+Dln2DGQhvMzA5pH
eWsOBKnwOEkEsfPhkDlDIPHyHOfMEw8tewpaEZBLtTm0Pk9G6I17fug2cZtvpOltFLiM4RJM
D+bC03PRpZzZG8TmTCNu4ySFw1RLUt56ZRGuOqu0n1cG641sMc4q5Uyudg5ReilIIuj+kzN2
3jIkgwcZZd60uT78LLM1MGZ6dwMqiGwwrJK6BTeK3Yq7jktdlVJuJ9yEawDjc0J4E/VDk/RN
FDLHUMjWqtUktxA93tlGhCEMASBaW6DvM5pukabUWKHwqg0tDespTKw8SU+CjkrzMPyA4Fh6
hRFy4TIq2LrgMtoU5SplJJIWKooEyK1fKE55P6JdFaPGVeC1yAWIZdYPAEbhgRQoKPcPmLmh
WBhuuVtIqU2EIc8AfloMoVxfxFgGrfOJfJ6mtVc8oHCc2Xy64AHSuRgXLBlGdgZihY3uzGx0
rVJiAZ7wXJ9vv1YosHTfhSlqKd5PUS4eWenSc4ZDewmXjp0+nXXp9cITRaCGr+US6qUhzE6u
xMpSr9i6tywkzFGjMrwYDj0eU0iWpg+sZ+lwhOEx6uxnJatT2hcQku/+5tjFIuBYBHuzy7fk
2ppdi4YWupLmeDpIdNbPRAmDJ8pgeFHQYijqy2GvEB5f+Q1sEjlGa2PoektYAQsaZfhf20jC
+Xw+n0T0HWKa0o3MO0o4xdbwZvnb++FhP9jki/rSTqH2+wft44aU2tvPfdi9fuzf+nen246k
WbvZlVufuptA+Ok2JaokfoomW5cd8NPiWgXUCXfubBcaBSFdn6FYJ6i1npUg1eo2hpTloqV8
Qbcllx6nNBN51ParJQo9KbIoYgAHa7ZPM1crWylac/yiiLmgCbmk0yWDv7v1zVOXSVLbZBAr
zXRlnqO8LQfbAzpM/tl3Lv0LvTLf9/vBx2ONIvbtLXeNGxV49cSduEmnxRP7z31S0r1pHbLh
Z5l2jCm1Scbr50ffGMHYXdJN/6Z1vXt7UO5C4nsywCyt78xRbUQ2duVGQf8CRt+2UoWezDyI
ZlZ1Pu7edvfIDk52fjVHlK199IbSE2C4jTls1/LWmAuVsRSbqM0xR5Np+5thU4mTuHIKYxzV
4uQu4XRy5SpnbAqrgKOwXuiMaCgryYNJ6Cv7lo1MdFi0WgoJbjpWvpBy1TGP1Rb6b4fdU9/x
RH+vslL2zAtYTXBGkwsy0QxDrZ1MWidhA7lEpnVFfJYJ8irDBLqulq+uSQgKN6MpcVZulPfT
JUXNMNJ7FDQQst1w8Ac+wsQdMIFunmLgnBss7SzY356FZHLkOJSmWIPQsyt0JUborjlbfHz5
hnkBrQZabb0EH9AlAGcbs4oTE2JpBX6tPq7SBHZMG0AzSMMOQlvy9BONMrsN/odZdpqci6Vg
TGlqhOfFjFDWIIZTkc8YhasGaZOHf6S7OjchNPQcTCyLacFccmiIFvnS/GxhbsboAStyltJ3
+Jq8zMMyTM/VoVAiXsL5+xzUQwUbhgn1xQrOdGHXpaPxeWnxr87MiDyZhUqFQMwLFc2QcccH
dqtDvtObcgpHiCpwPL1rr7dEmO62FL7ewlm3dWnlpina2dCzVUUE4j1xpQf/Uqo6+Myuvwa0
ILztfXrtPN/bcM1G4DfBhrXJJYYXlpXvcV/qGHl96R0ST0sXfkABsI3CbEjayVVw1dYJGVPX
AGYClCC9E03KoFTe0/VTM037GnEEDWY7prepN8gjTH9Eo1i7DzxWAcLucDKmbasb+pSxyq/p
hYUe+TPGo02T0fSJpQuHcUhQxJyJZIPEVIiCNhxBaqzu0mi+oOjq8g3WHxOOCyC5yCeTOd9z
QJ+OaQ6nyfMpzXWRfCPo46umpVk/pICauupVk8EPdPzW7o1/PsNMePo92D//2D/gofW7Rn2D
DRb9Hv/qzgkPVY6s9hIRfoAPO6ggAvW2/SUsY6aMsCAKbvjxsLYmwW2U8SrBmeC551uZXY35
wchF1AkRYRAb1beO/gj85wX4OpC+Vytxp5UCzArULmiwu6zWTDQpQEk3yUuQjXujnsDB7s2o
zRj6ljU6xzc6X8qFXlHE0GXEjWqcMWAC72DUQNxwZZtZCOE4vMmdjXxjamzytHU3g96VPd2I
Qatc3bs5yINHKgbR7h2H1DvxV8LnFQuo5CFaXEByIdTf6uqdaZq+cei2TRvwsWWfFh4LAeGw
RJGGu+FGDLv0kIhikS1z4qlHmFh6WricbySSa50kCwDx1QE+e8FIeIiwCMk4wIVghEcgFmgR
wAyKEefeSL27ja+jtFxddzqlmTjp2/HjeH980jOoN1/gHycrIBn9QDHUO+8DhigZBtNRwUjX
WAm7kPOU0QGsu44cOj1NiRAgMh3cPx3v/0PGQZJpOZw4TvXAVS+v1mdV91DqZQY2pqKh2No9
PKjoHsB3VcXv/zJ5X789RnNEjJI2Mcg471t3YTqhXAKnSFHVWr07OBk2IfrhFNuV2Ct+1l1D
RonVA1DNFVvlIP68e32FnVplI7YNlW92WVS3h7Q+CyEW5qPoNg6iAP6WC36oyKir4KlLiX8u
hvQ8VJA6Go51e66QGcuHFH0dbmmthqJGC2cKh1xuCPprueq+yC+XXRGzHaeXGqhGGFOp+/+9
wiymBtD10wksBMvw+Uyg2qpHttBttm92ixn3dssJwFikKwAITvMJIxZpwNKZzCwAmQpv5HRn
gLGZd7qoWgNLn+q6uuP71Cby15kOX0iH2Wv014gSY3WVQ/q8UoOCCsV4vSpU5nvjUddQxwgq
Rn0A7g5nPgCW/HBqqVYpuOaMgZAxKegjVQXwxmPHscyaVOQJE7WzWkuZO7zsunHXKo/+J3ar
hz1hQ0/6Ld3qNNniEfmGukaraOpRnFbQh1Myx5m7EPUAopuxxYTSG80Zv3ATp4s5i8M4jIyL
WR9WJSVL2rAcYw9EgFcRsqLEp9l9VSq+EBbS0tp6y/m8oUNE5FJb6NbFCK6JEV26Tuk5NjaE
ONm6t8mGuhFpMJX+SqlxQHLG13J8ogqMd6skBiitFVy0BqidtyeBbHcf948Px18gqu3x1dLj
58dgdQTO/nLsXprpctIs0NWUq3Z0ynaBfHScPFnKpjx+bVEITdeqOaPHm6x3QmQYAcVafh2Z
0gryt3Y6OuqPi8IOckFsmg0vhuXWZ467U9i2gnzBAiIYV3fUK6DeBvTbQU23owd4N/Zj6lnb
CCXT9+Q5NCtN8lwsOgr7nHKcWnj4zAYBR0Kv6dHn08fh5+fLvYo+Z4k2tfRL15PO/HLCuEkj
IB/PGL1aTR4x7CoCgUzJJky8DZXflSNn1o9p0AahIYE6X3Kq4RNqHXpMLDvEQH9N5hfM5q0A
/nwyG0Zb+uSkqinS0UWBOgYWEqFGmLEawU7x3fkFIw5hdiRPRuxx2IDYGqEgtFaxJk/pgWvI
tDZWk4dMhBTVAd4Qbe+tn1BjbN+wFtNLWJ/YafReIj0Vj9ejW4pkKJ6TbsMUyIzmF2mcVhhb
9o8b35Ue7IKcaSZgroKIqxrJjpNGDiNXn+j8CCr6lIkvU03DYng5mc1sgNlsalmdFcA20Arg
MJHmGsCcn0kK4FxaAc78wvoRzpyJDNPQ52fyz+nTk6LL6diWPYiXo+EioidocIfuW4wFEmb3
rFSQB+h7AyTCoWkCa5TvOfLwYNLl5MKW3ZvIiWOhXzkXfLdl8UROhzw9Dzw708/F5WxanMFE
E+YMoqhXtw4sAJ7JoSEiLVosisnFmU0pl1FqofJyN5IlBvAcjydFKXOQmHgOGKbjuWVxhKkz
Y07+upowsswgN4xc5vY3zafDiwkTvAGIE04fUxGZw7xqlAJYeEYFmPNcRwFGQ35R4ndDz1j2
WI2YTHnGoWux9C4CHOburQHMmX4yAPaNvAHZdlMAwV4ypheD3IZwkrbMZwCgy5h9wm/D4Wg2
tmPCaDyxsBTpjSfO3NJh11FhmRg3hWORaMLEW8fuitEkKtEtE3dJ7Fp7u8bYOnsbOZeWjRvI
46FdsNGQM5WMJxfnSpnPaTWOYsHJOgKBdjbktFUmCMRJC7OWKIJZOK2MlrSSynoWORWSBatN
yD/Ujna29avjvePO6m33+ni4f++bW9ysXBhPQ/OuE9RTISv1/LJh3+gzamNIL/209NoXt6pq
F7KYsRf1R5vJFc5LB3+6nw+H48A7No9G/4XXfqc3m1slfClDFW//bfe8H/z4/PkTLw+7BqLL
RfPq9W8jLU6kWN6aSS3nqDqwP/Q75e6KhcK/pQjDLPBkq2QkeEl6C9ndHkFE7ipYhKKl/sKS
gKeIVayfuydHAVCoc9KmLPSmBRgpQlWB7AS36nfVY32JTZyMsbkiyxjLKKCmES1VYEZ8GXLE
hXoAAJxXQvhKWiWhOimXLBF1UbyVAgDyoT9k/Z5x5JVBCkfNxA1LE7NL9psiV2YJW2cG52FG
GML+kLdDhvdUVPZT6Y0GKe6Ny4UaWKDFDNs7QQJTlDltAv3qNqPPe0Ab+10eeKLdJImfJDQD
RbJ0piP2a2Qm/F7EdaOHmDfk1DRlC/WASXG+oDjYi6hcFfJyQjpsAqB/1YXfITK5YXx1cZbU
8RFYwAL6gZ+7uWCfS0JqDjOfOSgiOZoNO4u2fhmE4qDVSxm7+/88HX49fmD0bc+3OBEAtfRC
N8+1jyjZCrxwV9Y5Fmj94oa9ZqPipGsEU78A0t0WT3nyZBNTfH2TA4NZeyAaAwMNA82OT1wc
6XoXNgcekzch2pcwDBMB8L8xd0mC9ObV2rXndwpnchiP+SKICoiH6enj7/fD/e6peoaD4vZx
kqoCCy8QtN4PqUpxfsMZFFlq6hTj+ism6JO8TZnohJgxS/DFdf7VvYhRQUQB7CfC496Z3JZh
wDzm6Hr4BK5YwEpnmLCA/8ZiwQXIz6RXzXRarkI16U03BHQVyDByF5ul8Rbtaeri0zggeNCr
ppPP+JRN4Ys87UR4b8jqUeDKtJi6/kMy3ikG8abtUK+SOWPEOldEvNoUHe7fju/Hnx+D9e/X
/du3m8Gvz/37R4uzNMFV7dBThass6Js01/0mYVuLqQsfT71EgwZBV5vuO8tAw0up1DVdDtCW
KYmRVi8/7/j8DNK9p0xjFDdF5zFz2LCgde7Tk/BUIArm80uHPuMZsFxMxpdMLLg2iom81EYN
mcBwLRAT9q8NYkKCGyDP94LZBX3G7cA4raYJy1HSLJmwLQYQ7QPhb++VyT7yxjtba+XD3TcZ
qs3n6elwKmq9xefOSbOtKlN+/Hxr3VnVHFJEQVa9PdFKOb3zUzeBKsbgia4IF215tXqPaP98
/Nhj3GZqn8B3uySG5qZj8xOZq0Jfn99/keWlUV6zCbrEVs7O/t2NJFzZfkDb/swr2+0EhgCt
sgfvr/v7w8/mMbBmd3Sfn46/IDk/epSlL0Wu8kGBGC6WydanVrLU23H3cH985vKR9MqBq0i/
L9/2+3fYW/eD6+ObuOYKOQdV2MO/ooIroEdTxOvP3RM0jW07STfHC61Xe4NVHJ4OL//rlakz
6Yv4G29Dzg0qc2Me86VZcKoqjVAUXWYB/RhEUGBsZE64SDJGNmBuxmJJGwLiqxfs06DbvvU0
Pl2hXlvqe9lk191geOh4JSwhYkQsPZN/9Ao3vguDnLEtrcxp4AecdMKQ8AvCwAT554/Kc6Jl
mFWbMPKBRcor1EyCMMiH70Dj1toEw2cc31sQSzloky2iwomuu1J4CxbBbhDCf9FS3FZcWrjl
yIkjNAFmXpUwUfiZfJ1uql7NLiM/mvaiGNYGcq2uNgpAEyX22o15NDtz+2Kq+/Lwdjw8tALX
xH6WdN+HrTmjhhsisEuZksbac9n82bbuXW8xCPg9uudTjqzMW+tVGJVubOjaNb1fpHF8TleM
Woix5s4Fow3KQxFxa0cFcPCqRyUZEWQT916ybx6PbdlEVfq+A2wC1fC3WOuNGwrflQE0H71m
8naRJ643Kpctz22dVBb4UAHHKsflkv48oF1ytCwQ0AoomqH/w5MKnrRa5iOOtpCW6mIRWrIu
R72czXRAKyVRwNHRCJkRFKgx6HZllVY9CFd23pGsi4NzHl7rXInYMP2LMPiAhG2nSzdmJQY4
zW6V7z0zb0s469GhzpZ5ox0/LdQqiUCLiqJeqW21we1naYjXm4R5mQJdNJc5O08qMjsw0AiO
ph84KwlDRW93/9h+PGqZe663ps/YGl3B/W/43CM+wYVrjVhqIk/mwKC5Vm38ZY9U10OXXekH
kvz70pXfY8nVG+WA4Wq9gbzs1JdE/9Y8hq622tff958Px8HPVnPqDQeODBUrMRPQREC2X0jH
ZBBdQj8LqIgnV0EWm8XUe4LBIPEP/wFEI5tVhWE0cEFVMeRbxSaZG68Cft65voW25GmBWqMc
dc1nBJIKGMbxNktbF5bm2Phvnx/WfZ65kTko1e+Kr3Xe/dOkzuuXp73xeuPma27OWvg8xpMv
2IUfWfox5WnXcXFppU65XSDTVZ76pEpB9Xfgl4vb/kPHXQDXRb2CEjKeaAVL4n5FaS45+wWY
+Dcsn7LMmqzPkWteoj3O2suqJnb6CH/fjDq/x93femc9sStMpTVTSMq3jJgLROoGYKXi8KQY
3ciwhFdTufMTam23DRpmXA4YhEpxZHCtTZylrWCcVYol4pgXpGuu/z3BERLf5bkSN2ShOSQh
3tEs3U0o//3H4f3oOJP5t6HxSD0CoJogdVdBeTmm755aoNmXQMwbdS2Qw5hldkD0GaoD+lJ1
X2i4w0Ri6YBonWwH9JWGMxbKHRCzPNqgr3TBlFbbdkDz86D5+Aslzb8ywPPxF/ppfvmFNjkz
vp9AisO5X9K39K1ihqOvNBtQ/CRwc4+Jy2i2hc9fI/ieqRH89KkR5/uEnzg1gh/rGsEvrRrB
D2DTH+c/hrnnaEH4z7lKhFMyL7/VZNrWFMkY/Bu2Zca6p0Z4QSgFE5i/gcQy2DBmGA0oS1zJ
mRI1oNtMhOGZ6lZucBaSBQFzvaoRAr6LuyRtMPFG0GqPVved+yi5ya4E8zo8YjZySa/iTSy8
nlNfbSFhKlJ00Lz7z7fDx2/jjrY5pLTjpuPvMguuN0EuS+JYWQtmGLsTRKRYYo4MTvTU9qyP
9YFPVVP6a7SPylT4W+YaNPA2eOwv/SjIlbZWZoLRNtVYK5EUItTdqQrWFENLUTOAFnGlG4Lk
hJqLdoD7DoyuTsJHeQqDVnCVERxRs5ZWjO90jYhTYR79+w+8GXs4/vfl79+7593fT8fdw+vh
5e/33c89lHN4+Pvw8rH/hUP7RzXSV/u3l/2TMpfbvxgBQetbJO3Afng5fBx2T4f/q20ZawVA
LCQ237vCyJEt5zVFAiFd9UvTdEZjU4OXsNhYbNunvtukmsx/0SmkWmd2nw53MPuaGFre2+/X
j+Pg/vi2HxzfBo/7p1f1dGsLjGFq3FSYB0QjedRPD1y/n7oIrzyRrs2XMrqUfqY1HCfJxD40
MzVspzSieWxtV2lKwDGUWT+5evam/zE6fdQ+NSvShlbTtjOWvsjRjVeFNcmJUjCSKF8KUqm6
1R+afdffuZFrYE42SDfSSqU2+vzxdLj/9p/978G9mk2/0Gzrd8t2Qo9GTmsMNdmnWb6mBt45
eubnfU9S9/Pjcf/ycbhXjw4HL6qJaMj938PH48B9fz/eHxTJ333siDZ7HvM4R0Ve2cneGnYL
d3SRJuHtcMx4wjWrZiVyzoxUY/LgmrHvanph7QKf6XteL5Q5wfPxwTStrlu58KgZs6SvkWoy
c3/QkGlNk27lgqgwzOjgqZqc2NuTwlfY6IVkzth66Qe324zRNNQDhKaEcmMdcLQ263f+evf+
2PR9r6folz9qXtd59aP+mjNfe9MptNI5H37t3z+oJmTemHHSMBHW7i2QK58pQg4vfEGHZqjX
07lSqJXU4aP+ZZ8p+xOiEyMBq0Vd/Fq/PYv8M8sSEYze4IQYMbEfT4gx48daL/61S73HVK8e
sUAE1NL7+iaZKHHStSjuIZgXSTWdMc+uyRJknQUXZ0FvKqtsOLc2Ypt2WllN4cPrY8u0yugI
N8gJqYTaTSG1Y9jSQ8SbhbAwM1Vf5vUnnU7slrdQL8WdWSsuvgrJODk0mFxaNxQETO3t9ol+
8sl+Wqq/Vg66du9cq4SRu2Hu2ud4vWHaN0EmandDz1LO2aCZtowpZC3nWHtebpPuANZGpK9v
+/f32hOq26/L0JX00bEekjtaJ6DJzqV1mYR31o8C8trK5+7ytoBYmf7tXh6Oz4P48/nH/m2w
2r/sDVev7kLJ8dGvjHkQqu6GbKHCltB6Fg36R0gZZAGaIDHHSUOkLuEQUv5/Zcey3LgNu/cr
cmxn2kx2m+luDznQEmVpLVG2HnaciyabelLPdrOZxJnp5xcA9aIE0OktIWCKDxAAQTzOyY0e
sWy1/3chn5lLj4c3Ho8M3zEHCj2W4yQyzac/hRjlEaJNDKID7/4NiMjwr679yjYglyrSt4FQ
nG2EFwTAxVkkVe4zDImBiz1aL9D9f34qDi8n9NoDLfuVqsS8Hh+f7k9vcON8+PvwgBU6XPd4
fGUCLkmRJmVvS2Gvye/pmzpPj19f7uFC/fLj7XR8cvUw9IbjHcsXCcgv9Kgf+Y53Tm5Y86Ou
knTyel2ECafNFW1Bo3k/lGotz9wk4qArwaonQhAdQIW8bPg7r5IVNElVN1xGKdLwJmP4/SPW
7oum1z4XIU0Cvdh/Zn5qIRJTIhRV7GSeiBgLwaIIUOFVBCAigLdSgyT0asDBZ2b2qg6TqttF
5yGY0qv7l+4OhS+m0FeTgoB3WBWd+1qJ5SqBiLYa9IpCjQJfMeIICGjsb2ebKJWyJaxRe5iN
gloNVraAFkQjC92I0LEZBoOVRoGuY2LHA7QPdqJwFsSNqKT71qkuyGMF65pBQShGaow/1i8M
ApUvbfEytUa40fg3o9NmUnR4m58+VeWg/f/h6GlJscFrBmdkgW2LwtEqlECek6OL5lizZDe/
Z1szbuSaKTueSK3PL8en0zdK//rX98PrIxdSZIscUCQBb5m28EBN/Xl7tkVlNzASLwV+l/ZP
xp9EjE2d6Goov5LBxRdfxWY9XA+joBx17VBCPQtkatdGnG+vYh3/OfyG2egsi38l1Afb/sKt
js07iyUKWHM8GdsyrIUQxDoYFbSKCtDCm50qzM2Hq4/X7hav4UiiS2smeUOqkDpWQt0SOyjJ
qUVj+i04w1iniCVELMqTJXcaUNLETJwHbd+lDlDmoFtUpiYhd91EJig02SY36X7eHVUJaHZa
rfChA88wL5Hfu0FD/xSujHK/2DBjtF9Hv7Fx1TTbih5fk3TB4eHr2+PjRKegB1sq+FNK7pS2
Q0QkNsIfI+wm3xlBeSTwOk/K3Mz0Fecr+eKL5u1j7c6lajFm2lvdrQJw+RR2YL47HcTzVfuC
UZdSWLnF2vrI1eRZVmOmC/F1qt0XiqmgBw9mkitVKmOHc/Php+mTx7CBPe8JrAhRJsi3bZ0t
1/umnWCcuBRkjV7Y30X64+Hb27Mlxfj+6XGWcjKlbKvQUwVbIyTxsMAmroG/V6rkF3u3EXI+
9l7e/HjGdGTgPMCxzHmfYgeOnuC1vrlygUOqz26KwNtCu06OsMJmlPvCWyP9yhKONqFlkJ59
x8+utF5zmStwxsPmXvz8+nx8ovzkv158fzsd/j3AH4fTw+Xl5S+DSYc8q6nvJQnVeeT2usi3
vQc1r91hHzhHz8BRUaorfas9h7KN95vTHfPLCcZuZ5HgZOc7zJfuG8qu1IJQsQg0H5lJtYUl
SK+B78FunOkLF5Yuxq3Gwn+bvgoHo6oLLWfcHybqVX/+BymMpS6QIZ1+/tMoumBZmtqggQjo
dl67aco0LSP2rU8iTLQVF2fgpU8KkHN9IiWCaUuIFBrzZiQqnfu8F0HNSzsAoIiO5G1CjLN7
SUjiciNUb0rO47EL/XTGNzsSm1ajKBhdwsG04RUgvfF2IbiXtEvZ6KKgMqpfrGLDItt3dz8O
3stMsK/yNcMPSCBHtbG6Ey1RMRHXPXRZqHXM44R7o/CMRgSddmDFXEbxQiBx0bAwChkGoMsP
u7l1fQ2zdccpXA+0zkChhHsP6O5G4AAABkEZ+Tqy8sKDEO9gZX0IrTreeUdYTCG/H8Ga0qh1
GeecorEADgBKLYgICrOZOm907coA/VCpS/sDgZX36MBjvIhWXnomuUhXZFfDqgDiASMIaJOw
/QugxTiTkuSMdo9uVbMT3Z3YtiomgpF4prkgsJ0YHuhDQlp2QhGhi44/E/f3MJYFvgp54GiU
gNtmjsH6IhaF2oHy0/g7A0YI7EWGdwYAQWKNJx7r27DOpLreuDL26u/L79XhlYFg1yaEFWBU
QvghIdAtmrfxEdyaJbxw4JdCZl/CqOtpCOgYeks2KBmOoVoR6DoyRoEG+woPu2fBJZs+QZOQ
N3BbOl4JVXppbmi2Fx3V7AKtfauLtuk4Jz7Fe2NECWjLsMhnji711qWq89ALhVl55sNYU1x6
I9c79Df00FyWezYcbnQBcG4v8ZMZXTDXdp2ICAATTx/dmU0Tqkqhhb2o5ajIUmF+LdGjkYyN
q2XouJ/g/2xn9aJUXBAbtWPy/qXJHKOo5X7AiaNULUvnujJ13LM2vv8AfoLXZTvbAAA=

--vkkcajgk3glfl4us--
